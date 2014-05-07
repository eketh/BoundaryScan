
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

--**********************************************************************************************************************************************************
-- PORTS (JTAG)
-- clk, nreset - generic clock and generic nreset (or rather nnreset because it is active low).
-- trigger - input that triggers testing process. Probably it will be some button.
-- TDO_jtag: data received from TDO pin of JTAG.
-- TDI_jtag: data sent to TDI pin of JTAG.
-- TMS - TMS signal sent to JTAG during states transition.
-- TRST - active low nreset signal sent to JTAG.
-- TCK - clock signal sent to JTAG.
--**********************************************************************************************************************************************************
-- For SWD, we connect only TCK and TMS, ignoring other pins.
-- Left and outcommented them just in case.
-- TMS set to inout.
--**********************************************************************************************************************************************************
-- VARIA
-- JTAG-to-SWD sequence is, according to ST's manual (RM0090, a.k.a. Mother Of All ST Manuals):
-- 1. Send more than 50 TCK cycles with TMS (SWDIO) = 1
-- 2. Send the 16-bit sequence on TMS (SWDIO) = 0111100111100111 (MSB transmitted first)
-- 3. Send more than 50 TCK cycles with TMS (SWDIO) = 1
-- Marked this as ToSwd to maintain the naming convence
-- 29 IV added Idle command (8 SWCLK pulses with TMS set to 0). Check whether it should be *after* 16 bits of JTAG-TO-SWD sequence or after the whole JTAG-
-- to-SWD cycle (more than 50 '1's, 16-bit sequence, more than 50 '1's @ SWDIO).
-- C'mon, no one reads these comments.
--**********************************************************************************************************************************************************
-- CONNECTION TO SWD header
-- 1- ???, 2- TCK, 3- GND, 4- TMS, 5-NRST, 6- TSWO
--**********************************************************************************************************************************************************

entity STM_SWD is
port(
  clk : in std_logic;
  nreset : in std_logic;
  trigger : in std_logic;
--  TDO_jtag: in std_logic;
--  TDI_jtag: out std_logic;
  TMS : inout std_logic; --inout for SWD
  nTRST : out std_logic;
  TCK : out std_logic;
--  TDO_led: out std_logic;
  nreset_led : out std_logic;
  state_led1 : out std_logic;
  state_led2 : out std_logic;
  
-- Output port capturing inout's response
-- (may not be needed)
  SWD_out : out std_logic
);
end STM_SWD;

architecture STM_SWD_a of STM_SWD is

type states is (snreset, sRun, sDataReg);
signal state, next_state: states;

signal pnreset: std_logic;
signal output_enable: std_logic;

constant RunLength: integer:= 134;


constant Idle: std_logic_vector (0 to 7) := "00000000"; -- 8 idle clock cycles after JTAG-to-SWD sequence are recommended
constant Zeros: std_logic_vector(0 to 51) := "0000000000000000000000000000000000000000000000000000";
constant SWDSeq: std_logic_vector (0 to 15) := "0111100111100111"; -- MSB first - this may be cumbersome...
constant IDCode: std_logic_vector (0 to 7) := "10101000"; -- DP access, read, register 0x00 = IDCODE
constant ToSWD: std_logic_vector (0 to 119) := NOT Zeros & SWDSeq & NOT Zeros;


-- For future applications: read processor ID
-- based on captured data saved in swd_tek2_marked.png
constant ReadIDAddress: std_logic_vector (0 to 7) := "11010001";
constant IDAddress: std_logic_vector (0 to 32) := "000000000000010000100000000001111"; -- Address= 0xE0042000, parity bit = 1
constant ReadRegister: std_logic_vector (0 to 7) := "11111001"; -- surround it w/few IDLE cycles with TDIO=1 not to get BUSY ACK!
constant ReadDPBuffer: std_logic_vector (0 to 7) := "10111101";



constant data_TMS: std_logic_vector (0 to RunLength):= ToSWD & Idle & IDCode(0 to 6); -- last bit of IDCODE is not driven by host, 
--so let's don't mention it (for testing purpose).

constant max_prescaler: integer := 100;
constant half_prescaler: integer := 50;
constant shift_prescaler: integer := 75; -- some value "considered safe" where shift register is shifted

signal clk_prescaler: integer range max_prescaler downto 0;

signal bit_count: integer range RunLength downto 0; -- showing which bit is actually sent

signal a_trigger, trigger_strobe: std_logic; --auxiliary signals of edge detector @ trigger input
signal sample: std_logic;
signal sTCK: std_logic;
begin

--**********************************************************************************************************************************************************
trigger_edge: process (clk,nreset)
begin
if (nreset='0') then
  a_trigger<='0';
  trigger_strobe<='0';
elsif (clk'event and clk='1') then
  if (a_trigger='0' and trigger='1') then
    trigger_strobe<='1';
  else
    trigger_strobe<='0';
  end if;
end if;
end process trigger_edge;

TCK_prescaler: process (clk, nreset)
begin
if (nreset='0') then
  clk_prescaler<=0;
elsif (clk'event and clk='1') then
    clk_prescaler<=clk_prescaler+1;
  if (clk_prescaler=max_prescaler) then
    clk_prescaler<=0;
  end if;
end if;
end process TCK_prescaler;

bitcounting:process (clk,nreset)
begin
if (nreset='0') then
  bit_count<=0;
elsif (clk'event and clk='1') then
  if (state=sRun) then
    if (clk_prescaler = shift_prescaler ) then
	   if (bit_count<RunLength) then
        bit_count<= bit_count+1;
		end if;
    end if;
  else
bit_count<=0;
  end if;
end if;
end process bitcounting;

fsm_reg: process (nreset,clk)
begin
if (nreset='0') then
  state<=snreset;

elsif (clk'event and clk='1') then
  state<=next_state;
end if;
end process fsm_reg;

fsm:process (state, trigger_strobe, clk_prescaler, bit_count)
begin

case state is
  when snreset =>
  if (trigger_strobe='1') then
    next_state<=sRun;
  else
    next_state<=snreset;
  end if;
  
  when sRun =>
  if (clk_prescaler=(max_prescaler-1) and bit_count=RunLength) then
    next_state<=sDataReg;
  else
    next_state<=sRun;
  end if;
  
  when sDataReg =>
      next_state<=sDataReg;

  when others =>
    next_state<=snreset;
  end case;	

end process fsm;

datareg: process (clk, nreset)
begin
if (nreset = '0') then
  output_enable <= '1';
elsif (clk'event and clk = '1') then
  if (state = sRun) then
    output_enable <= '1';
  elsif (state = sDataReg) then
    output_enable <= '0'; 
  else
    output_enable <= '1';  
  end if;
end if;
end process datareg;

SWD_out <= '1' when (output_enable = '1') else TMS;
TMS <= '1' when (nreset = '0') else data_TMS(bit_count) when (output_enable = '1');
sTCK <= '0' when (state /= snreset and clk_prescaler<half_prescaler) else '1';
TCK <= sTCK;
nTRST <= nreset;
pnreset <= NOT nreset;
nreset_led <= NOT nreset;
state_led1 <= sTCK;
state_led2 <= TMS;

end STM_SWD_a;
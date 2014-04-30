
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

--**********************************************************************************************************************************************************
-- PORTS (JTAG)
-- clk, reset - generic clock and generic reset (or rather nreset because it is active low).
-- trigger - input that triggers testing process. Probably it will be some button.
-- TDO_jtag: data received from TDO pin of JTAG.
-- TDI_jtag: data sent to TDI pin of JTAG.
-- TMS - TMS signal sent to JTAG during states transition.
-- TRST - active low reset signal sent to JTAG.
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
-- PS Now code is in its "battlefield" version, but it will be refractored from JTAG signals once it starts to work properly.
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
  reset : in std_logic;
  trigger : in std_logic;
  button : in std_logic;
  test	: in std_logic;
  test_out : out std_logic;
--  TDO_jtag: in std_logic;
--  TDI_jtag: out std_logic;
  TMS : inout std_logic; --inout for SWD
  nTRST : out std_logic;
  TCK : out std_logic;
--  TDO_led: out std_logic;
  reset_led : out std_logic;
  state_led1 : out std_logic;
  state_led2 : out std_logic;
  state_led3 : out std_logic;
  
-- Output port capturing inout's response
-- (may not be needed)
  SWD_out : out std_logic
);
end STM_SWD;

architecture STM_SWD_a of STM_SWD is

type states is (sReset, sRun, sDataReg);
signal state, next_state: states;

--reverse to make TAP state machine trackable.
--constant ToIR: std_logic_vector (0 to 9):= "1110001100";
--constant IRtoDR: std_logic_vector (0 to 4):= "11100";
--constant ToRun: std_logic_vector (0 to 2):= "110";
--constant DRtoDR: std_logic_vector(0 to 4):= "11100";
--constant DRtoIR: std_logic_vector(0 to 5):= "111100";

--constant ILength: integer := 3;
constant RunLength: integer:= 151;

--constant IRData1: std_logic_vector (0 to ILength):= "1100";-- 3=IDCODE
--constant IRData2: std_logic_vector (0 to ILength):= "110111111";-- APACC

constant Zeros: std_logic_vector(0 to 59) := "000000000000000000000000000000000000000000000000000000000000";
constant SWDSeq: std_logic_vector (0 to 15) := "0111100111100111"; -- MSB first - this may be cumbersome...
constant IDCode: std_logic_vector (0 to 7) := "10100101"; -- DP access, read, register 0x00 = IDCODE
constant ToSWD: std_logic_vector (0 to 135) := NOT Zeros & SWDSeq & NOT Zeros;
constant Idle: std_logic_vector (0 to 7) := "00000000"; -- 8 idle clock cycles after JTAG-to-SWD sequence are recommended

-- For future applications: read processor ID
-- based on captured data saved in swd_tek2_marked.png
constant ReadIDAddress: std_logic_vector (0 to 7) := "11010001";
constant IDAddress: std_logic_vector (0 to 32) := "000000000000010000100000000001111"; -- Address= 0xE0042000, parity bit = 1
constant ReadRegister: std_logic_vector (0 to 7) := "11111001"; -- surround it w/few IDLE cycles with TDIO=1 not to get BUSY ACK!
constant ReadDPBuffer: std_logic_vector (0 to 7) := "10111101";


--constant DPData1: std_logic_vector (0 to 35):="010000001000000000000000000000010100"; --ctrl/stat reg.value
--constant DPData2: std_logic_vector (0 to 35):="001000000000000000000000000000000000"; --ap select
--constant APData1: std_logic_vector (0 to 35):="100010000100000000000000000110001000"; --"000010000100000000000000000110001000"; --CSW - 32-b read size etc.
--constant APData2: std_logic_vector (0 to 35):="010000010000101111011111111111110000"; --write + TAR + 0x1FFF:7A10- device id register 
--constant APData3: std_logic_vector (0 to 35):="011000000000000000000000000000101010"; --write + CSW + XXXX...
--constant APData4: std_logic_vector (0 to 35):="111000000000000000000000000000000000"; --read + CSW + XXXX...



constant data_TMS: std_logic_vector (0 to RunLength):= ToSWD & Idle & IDCode;-- & zeros(0 to 35) & DRtoDR & zeros(0 to 35) & DRtoIR & zeros(0 to ILength) & IRtoDR & zeros(0 to 35) & DRtoDR & zeros(0 to 35) & DRtoDR & zeros(0 to 35) & DRtoDR & zeros(0 to 35) & DRtoDR & zeros(0 to 35) & DRtoDR & zeros(0 to 35) & DRtoDR & zeros(0 to 35) & DRtoDR;

--constant data_TDI: std_logic_vector (0 to RunLength):= Zeros(0 to 10) & IRData1 & zeros(0 to 3);-- & DPData1 & zeros(0 to 4) & DPData2 & zeros(0 to 5) & IRData2 & zeros(0 to 4) & APData1 & Zeros (0 to 4) & APData2 & Zeros (0 to 4) & APData3 & Zeros (0 to 4) & APData4 & Zeros (0 to 4) & APData4 & Zeros (0 to 4) & APData4 & Zeros (0 to 4)  & APData4 & Zeros (0 to 3);

--prescaler values for TCK.
constant max_prescaler: integer := 4900000;
constant half_prescaler: integer := 2400000;
constant shift_prescaler: integer := 3600000; -- some value "considered safe" where shift register is shifted

signal clk_prescaler: integer range max_prescaler downto 0;

signal bit_count: integer range RunLength downto 0; -- showing which bit is actually sent

signal a_trigger, trigger_strobe: std_logic; --auxiliary signals of edge detector @ trigger input
signal sample: std_logic;
signal sTCK: std_logic;
begin

--**********************************************************************************************************************************************************
trigger_edge: process (clk,reset)
begin
if (reset='0') then
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

TCK_prescaler: process (clk, reset)
begin
if (reset='0') then
  clk_prescaler<=0;
elsif (clk'event and clk='1') then
    clk_prescaler<=clk_prescaler+1;
  if (clk_prescaler=max_prescaler) then
    clk_prescaler<=0;
  end if;
end if;
end process TCK_prescaler;

bitcounting:process (clk,reset)
begin
if (reset='0') then
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

fsm_reg: process (reset,clk)
begin
if (reset='0') then
  state<=sReset;

elsif (clk'event and clk='1') then
  state<=next_state;
end if;
end process fsm_reg;

fsm:process (state, trigger_strobe, clk_prescaler, bit_count)
begin

case state is
  when sReset =>
  if (trigger_strobe='1') then
    next_state<=sRun;
  else
    next_state<=sReset;
  end if;
  
  when sRun =>
  if (clk_prescaler=(max_prescaler-1) and bit_count=RunLength) then
    next_state<=sDataReg;
  else
    next_state<=sRun;
  end if;
  
  when sDataReg =>
--    if (trigger_strobe='1') then
      next_state<=sDataReg;
--    else
--      next_state<=sDataReg;
--   end if;

  when others =>
    next_state<=sReset;
  end case;	

end process fsm;

datareg: process (clk, reset)
begin
if (reset = '0') then
--TDI_jtag<='0';
  TMS <= '1';
  SWD_out <= '1';
elsif (clk'event and clk = '1') then
  if (state = sRun) then
--  TDI_jtag<= data_TDI(bit_count);
    TMS <= data_TMS(bit_count);	
	 SWD_out <= '1';
  elsif (state = sDataReg) then
--  TDI_jtag<=button;
--    TMS<='1';
	 SWD_out<=TMS;
  else
--  TDI_jtag<='0';
    TMS<='1';
    SWD_out <= '1';	 
  end if;
end if;
end process datareg;

sTCK <= '0' when (state /= sReset and clk_prescaler<half_prescaler) else '1';
TCK <= sTCK;
nTRST <= reset;
--TDO_led<=TDO_jtag;
reset_led <= reset;
state_led1 <= sTCK;
state_led2 <= TMS;
state_led3 <= button;
test_out<=test;
--TMS<= data_TMS(bit_count);
--TDI_jtag<= data_TDI(bit_count);

end STM_SWD_a;
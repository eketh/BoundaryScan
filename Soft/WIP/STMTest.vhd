
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

--**********************************************************************************************************************************************************
-- PORTS
-- clk, reset - generic clock and generic reset (or rather nreset because it is active low).
-- trigger - input that triggers testing process. Probably it will be some button.
-- TDO_jtag: data received from TDO pin of JTAG.
-- TDI_jtag: data sent to TDI pin of JTAG.
-- TMS - TMS signal sent to JTAG during states transition.
-- TRST - active low reset signal sent to JTAG.
-- TCK - clock signal sent to JTAG.
--**********************************************************************************************************************************************************

entity STM_Quartus is
port(
  clk: in std_logic;
  reset: in std_logic;
  trigger: in std_logic;
  button: in std_logic;
  TDO_jtag: in std_logic;
  TDI_jtag: out std_logic;
  TMS: out std_logic;
  TRST: out std_logic;
  TCK: out std_logic;
  TDO_led: out std_logic;
  reset_led: out std_logic;
  state_led1: out std_logic;
  state_led2: out std_logic;
  state_led3: out std_logic
);
end STM_Quartus;

architecture STMTest_a of STM_Quartus is

type states is (sReset, sRun, sDataReg);
signal state, next_state: states;

--reverse to make TAP state machine trackable.
constant ToIR: std_logic_vector (0 to 9):= "1110001100";
constant IRtoDR: std_logic_vector (0 to 4):= "11100";
constant ToRun: std_logic_vector (0 to 2):="110";
constant DRtoDR: std_logic_vector(0 to 4):="11100";
constant DRtoIR: std_logic_vector(0 to 5):="111100";

constant ILength: integer :=3;
constant RunLength: integer:=18;

constant IRData1: std_logic_vector (0 to ILength):= "1100";-- 3=IDCODE
--constant IRData2: std_logic_vector (0 to ILength):= "110111111";-- APACC

--constant DPData1: std_logic_vector (0 to 35):="010000001000000000000000000000010100"; --ctrl/stat reg.value
--constant DPData2: std_logic_vector (0 to 35):="001000000000000000000000000000000000"; --ap select
--constant APData1: std_logic_vector (0 to 35):="100010000100000000000000000110001000"; --"000010000100000000000000000110001000"; --CSW - 32-b read size etc.
--constant APData2: std_logic_vector (0 to 35):="010000010000101111011111111111110000"; --write + TAR + 0x1FFF:7A10- device id register 
--constant APData3: std_logic_vector (0 to 35):="011000000000000000000000000000101010"; --write + CSW + XXXX...
--constant APData4: std_logic_vector (0 to 35):="111000000000000000000000000000000000"; --read + CSW + XXXX...

constant Zeros: std_logic_vector(0 to 35):="000000000000000000000000000000000000"; -- czy da sie to robic nie w tak lopatologiczny sposob? 

constant data_TMS: std_logic_vector (0 to RunLength):= ToIR & Zeros(0 to Ilength) & IRtoDR;-- & zeros(0 to 35) & DRtoDR & zeros(0 to 35) & DRtoIR & zeros(0 to ILength) & IRtoDR & zeros(0 to 35) & DRtoDR & zeros(0 to 35) & DRtoDR & zeros(0 to 35) & DRtoDR & zeros(0 to 35) & DRtoDR & zeros(0 to 35) & DRtoDR & zeros(0 to 35) & DRtoDR & zeros(0 to 35) & DRtoDR;

constant data_TDI: std_logic_vector (0 to RunLength):= Zeros(0 to 10) & IRData1 & zeros(0 to 3);-- & DPData1 & zeros(0 to 4) & DPData2 & zeros(0 to 5) & IRData2 & zeros(0 to 4) & APData1 & Zeros (0 to 4) & APData2 & Zeros (0 to 4) & APData3 & Zeros (0 to 4) & APData4 & Zeros (0 to 4) & APData4 & Zeros (0 to 4) & APData4 & Zeros (0 to 4)  & APData4 & Zeros (0 to 3);

--prescaler values for TCK.
constant max_prescaler: integer := 49;
constant half_prescaler: integer := 24;
constant shift_prescaler: integer := 36; -- some value "considered safe" where shift register is shifted

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
if (reset='0') then
  TDI_jtag<='0';
  TMS<='1';
elsif (clk'event and clk='1') then
  if (state=sRun) then
    TDI_jtag<= data_TDI(bit_count);
    TMS<= data_TMS(bit_count);	
  elsif (state=sDataReg) then
    TDI_jtag<=button;
    TMS<='0';
  else
    TDI_jtag<='0';
    TMS<='1';
  end if;
end if;
end process datareg;

sTCK<= '0' when (state /= sReset and clk_prescaler<half_prescaler) else '1';
TCK<=sTCK;
TRST<=reset;
TDO_led<=TDO_jtag;
reset_led<=reset;
state_led1<='1' when (state=sReset) else '0';
state_led2<='1' when (state=sRun) else '0';
state_led3<='1' when (state=sDataReg) else '0';

--TMS<= data_TMS(bit_count);
--TDI_jtag<= data_TDI(bit_count);

end STMTest_a;
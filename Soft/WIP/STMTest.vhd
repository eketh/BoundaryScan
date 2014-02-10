
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

--**********************************************************************************************************************************************************
-- TODO
-- *dostosowac do jtaga w STM32F4.
-- *dodac wyswietlanie DRData np. na LCDku Spartana 3E, zebysmy wiedzieli, czy w ogóle cos otrzymujemy od ukladu.
-- *w dalekiej przyszlosci: dodac opcje zapisywania pamieci Flash. :)

-- OPEN ISSUES
-- *jak update'owac instrukcje tylko w boundary scanie albo tylko w Corteksie?
--**********************************************************************************************************************************************************
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

entity STMTest is
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
end STMTest;

architecture STMTest_a of STMTest is

type states is (sReset, sRun, sDataReg);
signal state, next_state: states;

--sDataReg: nic nie powinno stamtad uciekac. neva eva.

--reverse to make TAP state machine trackable.
constant ToShiftIR: std_logic_vector (0 to 4):= "01100";
constant ToShiftDR: std_logic_vector (0 to 5):= "110100";
constant ToRun: std_logic_vector (0 to 2):="110";

constant ILength: integer :=5;
constant RunLength: integer:=22;

constant IRData: std_logic_vector (Ilength downto 0):= "111111"; --Instruction code to be sent to JTAG
constant AllZeros: std_logic_vector(0 to 17):="000000000000000000"; -- czy da sie to robic nie w tak lopatologiczny sposob? :(

constant data_TMS: std_logic_vector (0 to RunLength):= ToShiftIR & AllZeros(0 to (Ilength)) & ToShiftDR & ToRun & "000";--ToShiftIR & AllZeros(0 to (Ilength-1)) & ToShiftDR & ToRun & "000";-- showing which bit is actually sent
constant data_TDI: std_logic_vector (0 to RunLength):= "11111111111111111111111"; --AllZeros(0 to 4) & IRData & AllZeros(0 to 10);


--prescaler values for TCK.
-- For testing purposes, reduce them to i.e. 3-bit values not to wait for result for ages.
constant max_prescaler: integer := 49;
constant half_prescaler: integer := 24;
constant shift_prescaler: integer := 12; -- some value "considered safe" where shift register is shifted

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
    if (clk_prescaler = half_prescaler ) then
      bit_count<= bit_count+1;
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
  if (clk_prescaler=max_prescaler and bit_count=RunLength) then
    next_state<=sDataReg;
  else
    next_state<=sRun;
  end if;  
  
  when sDataReg =>
    if (trigger_strobe='1') then
	   next_state<=sReset;
	 else
	   next_state<=sDataReg;
  	end if;
	  
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

sTCK<= '0' when (clk_prescaler<half_prescaler) else '1';
TCK<=sTCK;
TRST<=reset;
TDO_led<=TDO_jtag;
reset_led<=reset;
state_led1<='1' when (state=sDataReg) else '0';
state_led2<='1' when (state=sRun) else '0';
state_led3<='1' when (state=sReset) else '0';

--TMS<= data_TMS(bit_count);
--TDI_jtag<= data_TDI(bit_count);

end STMTest_a;


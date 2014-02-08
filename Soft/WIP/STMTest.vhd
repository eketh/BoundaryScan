
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
  TDO_jtag: in std_logic; 
  TDI_jtag: out std_logic; 
  TMS: out std_logic; 
  TRST: out std_logic; 
  TCK: out std_logic 
);
end STMTest;

architecture STMTest_a of STMTest is
--reverse to make the state machine trackable.
constant ToShiftIR: std_logic_vector (0 to 4):= "01100";
constant ToShiftDR: std_logic_vector (0 to 5):= "110100";
constant ToRun: std_logic_vector (0 to 2):="110";

constant ILength: integer :=3;
constant IRData: std_logic_vector (Ilength downto 0):= "1111"; --Instruction code to be sent to JTAG
constant zeros: std_logic_vector(0 to 17):="000000000000000000"; -- czy da sie to robic nie w tak lopatologiczny sposob? :(
constant ones: std_logic_vector (0 to 17):="111111111111111111";

constant data_TMS: std_logic_vector (0 to 19):= ToShiftIR & zeros(0 to (Ilength-1)) & ToShiftDR & ToRun & "000";-- showing which bit is actually sent
constant data_TDI: std_logic_vector (0 to 19):= zeros(0 to 4) & IRData & zeros(0 to 10);


--prescaler values for TCK.
-- For testing purposes, reduce them to i.e. 3-bit values not to wait for result for ages.
constant max_prescaler: integer := 8;--49;
constant half_prescaler: integer := 4;--24;
constant shift_prescaler: integer := 2;--12; -- some value "considered safe" where shift register is shifted
constant tms_prescaler: integer :=6;
signal clk_prescaler: integer range max_prescaler downto 0;

--signal DRData: std_logic_vector (3 downto 0); -- data received from JTAG

signal bit_count: integer range 19 downto 0; -- showing which bit is actually sent

signal a_trigger, trigger_strobe: std_logic; --auxiliary signals of edge detector @ trigger input
signal sample: std_logic;
signal sTCK: std_logic;
begin

--**********************************************************************************************************************************************************
--PROCESSES
--trigger_edge: edge detector @ trigger input. Active only in these states where it is required not to make some mess in the others and to save energy as well.
--tck_prescaler: sets clock for JTAG. According to BSDL files for STM32 family, its value should be somewhat smaller than 10 MHz. Inactive in TRESET state.
--fsm_reg: process synchronizing state machine with CLK signal
--fsm: finite state machine with the following states:
-- Reset: default state after reset
-- To_ShiftIR/To_ShiftDR, To_RunTest: known sequences sent on TMS used to reach the desired state in device TAP. Just a known sequence of TMS in each case.
-- SHIFTIR, SHIFTDR: processes sending data from 2 shift registers (DRData, IRData) into IR and DR. In the first case, instruction register is being shifted
-- out to the device. In the second case, data register is shifted in from the device.
--BitShift: main process shifting bits out and into the device in all the states where some bits are being shifted (To_Shiftir/dr, SHIFTIR/DR, ToRunTest).
-- It chooses register out of which/into which data are shifted.
-- I think that it works right now :P
--**********************************************************************************************************************************************************

trigger_edge: process (clk,reset)
begin
if (reset='0') then
  a_trigger<='0';
  trigger_strobe<='0';
elsif (clk'event and clk='1') then
 -- if (state= TReset or state=RunTest) then
    if (a_trigger='0' and trigger='1') then
      trigger_strobe<='1';
    else
      trigger_strobe<='0';
    end if;
--  end if;
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

--te 2 u gory na pewno dobrze!!!--


bitcounting:process (clk,reset)
begin
if (reset='0') then
  bit_count<=0;
--  a_state<=TReset;
elsif (clk'event and clk='1') then
--  a_state<=state;
 -- if (a_state /= state) then
 --   bit_count<=0;
  if (clk_prescaler = half_prescaler ) then --and state=next_state
    bit_count<= bit_count+1;
  end if;
end if;
end process bitcounting;


sTCK<= '0' when (clk_prescaler<half_prescaler) else '1';
TCK<=sTCK;

TMS<= data_TMS(bit_count);
TDI_jtag<= data_TDI(bit_count);

end STMTest_a;


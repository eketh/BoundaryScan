
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

--**********************************************************************************************************************************************************
-- TODO
-- *dostosowac do jtaga w STM32F4.
-- *dodac wyswietlanie DRData np. na LCDku Spartana 3E, zebysmy wiedzieli, czy w og�le cos otrzymujemy od ukladu.
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

type states is (TReset, To_ShiftIR, SHIFTIR, To_ShiftDR, SHIFTDR, To_RunTest, RunTest);
signal state, next_state: states;

constant SHIFTIRData: std_logic_vector (4 downto 0):= "01100";
constant SHIFTDRData: std_logic_vector (4 downto 0):= "11100";
constant RunTestData: std_logic_vector (2 downto 0):="110";

--prescaler values for TCK.
-- For testing purposes, reduce them to i.e. 3-bit values not to wait for result for ages.
constant max_prescaler: integer := 7;--49;
constant half_prescaler: integer := 3;--24;
constant shift_prescaler: integer := 3;--12; -- some value "considered safe" where shift register is shifted.
signal clk_prescaler: integer range max_prescaler downto 0;

signal DRData: std_logic_vector (3 downto 0); -- data received from JTAG
constant IRData: std_logic_vector (3 downto 0):= "0011"; --Instruction code to be sent to JTAG
signal bit_count: integer range 4 downto 0; -- showing which bit is actually sent

signal a_trigger, trigger_strobe: std_logic; --auxiliary signals of edge detector @ trigger input
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
  if (state= TReset or state=RunTest) then
    if (a_trigger='0' and trigger='1') then
      trigger_strobe<='1';
    else
      trigger_strobe<='0';
    end if;
  end if;
end if;
end process trigger_edge;

TCK_prescaler: process (clk, reset)
begin
if (reset='0') then
  TCK<='0';
  clk_prescaler<=0;
elsif (clk'event and clk='1') then
  if (state /= TReset) then
    clk_prescaler<=clk_prescaler+1;
	 if (clk_prescaler=max_prescaler) then
	   clk_prescaler<=0;
	 end if;
    if (clk_prescaler<half_prescaler) then
      TCK<='0';
    else
      TCK<='1';
    end if;
  end if;
end if;
end process TCK_prescaler;

fsm_reg: process (clk, reset)
begin
if (reset='0') then
  state<=TReset;
elsif (clk'event and clk='1') then
  state<=next_state;
end if;
end process fsm_reg;

fsm: process (trigger_strobe,clk_prescaler, bit_count)
begin
case state is
  when TReset =>
    if (trigger_strobe='1') then
	   next_state<=To_ShiftIR;
	 end if;
  when To_ShiftIR =>
    if (clk_prescaler=max_prescaler and bit_count=4) then
	   next_state<=SHIFTIR;
	 end if;
  when SHIFTIR =>
    if (clk_prescaler=max_prescaler and bit_count=3) then
	   next_state<=To_ShiftDR;
	 end if;    
  when To_ShiftDR =>
    if (clk_prescaler=max_prescaler and bit_count=4) then
	   next_state<=SHIFTDR;
	 end if;  
  when SHIFTDR =>
    if (clk_prescaler=max_prescaler and bit_count=3) then
	   next_state<=To_RunTest;
	 end if;    
  when To_RunTest =>
    if (clk_prescaler=max_prescaler and bit_count=3) then
	   next_state<=RunTest;
	 end if;  
  when RunTest =>
    if (trigger_strobe='1') then
	   next_state<=TReset;
	 end if;    
  when others =>
    next_state<= TReset; --must go to reset because otherwise an extra state "From_Run_To_ShiftIR" would be required!!!
end case;
end process fsm;

BitShift: process (clk, reset)
begin
if (reset='0') then
  TMS<='1'; --we assume that we are in TestLogicReset state right now. When we send 1, TAP remains in this state.
  TRST<='0';
  TDI_jtag<='0'; --no idea whether 0 or 1 changes something in that case.
  bit_count<=0;
  DRData<=(others=>'0');
elsif (clk'event and clk='1') then
  if (next_state /= state) then
    bit_count<=0;
  elsif (clk_prescaler = shift_prescaler) then
    bit_count<= bit_count+1;
  end if;
    if (state= To_ShiftIR) then
	   TDI_jtag<=SHIFTIRData(bit_count);
    elsif (state=SHIFTIR) then
	   TDI_jtag<=IRData(bit_count);
    elsif (state=To_ShiftDR) then
	   TDI_jtag<=SHIFTDRData(bit_count);
    elsif (state=SHIFTDR) then
	   DRData(bit_count)<=TDO_jtag;
    elsif (state=To_RunTest) then
	   TDI_jtag<=RunTestData(bit_count);
    else
	   TDI_jtag<='0';
    end if;
end if;
end process BitShift;

end STMTest_a;


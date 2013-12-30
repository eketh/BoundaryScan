
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--**************************************************************************************************************************************
-- TDI,TDO - Test Data In/Out, for testing purposes coming from previous cell
-- On picture: Serial In & Serial Out
-- NDI,NDO - Normal Data In/Out, for "normal work" purposes
-- On picture: Parallel in & Parallel Out
-- (c) Natalia Pyka, 23 XII 2013, 11:30
--**************************************************************************************************************************************
entity bscell is
port(
  TDI				: 	    in  std_logic;
  NDI				:    	in  std_logic;
  CLOCKDR			:  		in  std_logic;
  MODE			    : 		in  std_logic;
  UPDATEDR			:	    in  std_logic;
  TDO				:	    out std_logic;
  NDO				:	    out std_logic
  
);
end bscell;

architecture bscell_a of bscell is
--**************************************************************************************************************************************
-- BSCClock: register synchronized by CLOCKDR
-- BSCUpdate: register synchronized by UPDATEDR
--**************************************************************************************************************************************

signal BSCClock : std_logic;
signal BSCUpdate : std_logic;
begin

TDO<=BSCClock;
NDO<=BSCUpdate;

TestWork:process (CLOCKDR, UPDATEDR, MODE)
begin
--first multiplexer: MODE -dependent
if (MODE='0') then
  NDO<=NDI;
else
  if (CLOCKDR'event and CLOCKDR='1') then
--second multiplexer: SHIFTDR-dependent
    BSCClock<= TDI when SHIFTDR='1' else NDI;
  end if;
  if (UPDATEDR'event and UPDATEDR='1') then
  BSCUpdate<=BSCClock; 
   end if;
end if;
end process TestWork;
end bscell_a;


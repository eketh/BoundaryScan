library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity JTAGIDRegister is
port(
--serial input/output
TDI       : in std_logic;
TDO       : out std_logic;
TCK       : in std_logic; --required for events occuring @ falling edge of TCK. Me thinks.
TRST      : in std_logic; --asynchronous reset
-- instruction register:
SHIFTIR   : in std_logic;
CLOCKIR   : in std_logic;
UPDATEIR  : in std_logic;
TRESET    : in std_logic; --reset from TAP (@ falling edge of TCK in Reset state)
--data register:
SHIFTDR   : in std_logic;
CLOCKDR   : in std_logic;
UPDATEDR  : in std_logic;
--optional signals used to set some values
CAPTUREDR : in std_logic;
CAPTUREIR : in std_logic
);
end JTAGIDRegister;

architecture JTAGIDRegister_a of JTAGIDRegister is

type istate is (NONE, BYPASS, EXTEST, INTEST, SAMPLE, PRELOAD, IDCODE, UNKNOWN);
signal DecodedInstruction 								: istate;

--Instruction register signals:
-- right now, shortened to 4 bits in order to faciliate testing!

subtype Instruction is std_logic_vector(3 downto 0);
signal InstructionShift                         : instruction;
signal CurrentInstruction, a_CurrentInstruction : instruction;
signal InstrChange                              : std_logic; -- auxiliary bit used when testing to indicate instruction change;

--Data register signals:
signal DevID												: std_logic_vector(3 downto 0); --device ID register
signal BScan												: std_logic_vector(3 downto 0); --boundary scan register
signal BYP													: std_logic; --bypass register

begin

--***************************************************************************************************************************************************************************************************
--Common part
--processes:
--end of common part
--***************************************************************************************************************************************************************************************************

--***************************************************************************************************************************************************************************************************
--Instruction register part
--processes:
-- IShift: Shift register + updating the instruction code
-- ChangeTickIR: auxiliary signal going high for 1 TCK when instruction has changed. Used only for testing purposes. - outcommented, no longer needed (NP)
-- Out of process: MUX decoding instruction code. Also auxiliary - if library containing instruction codes will be used, this may become unnecessary.
--***************************************************************************************************************************************************************************************************
IShift: process (TRST,TCK,TRESET,CLOCKIR,UPDATEIR)
begin
if (TRST='0' OR TRESET='0') then
  InstructionShift<=(others=>'0');
  CurrentInstruction<=(others=>'1'); --<=BYPASS_CODE;
elsif (CLOCKIR'event and CLOCKIR='1') then
  if (SHIFTIR='1') then -- check whether it is the rising edge!!!
    InstructionShift<= TDI & InstructionShift(3 downto 1);
    TDO<=InstructionShift(0);
  end if;
elsif (UPDATEIR='1') then -- same here 
  if (falling_edge(TCK)) then
    CurrentInstruction<=InstructionShift;  
  end if;
end if;
end process IShift;

--Decoded instruction: out of the process (just an optional info for us)
DecodedInstruction <= NONE    when (CurrentInstruction="0000") else 
							 BYPASS  when (CurrentInstruction="1111") else --bypass
							 EXTEST  when (CurrentInstruction="0111") else --bscan
							 INTEST  when (CurrentInstruction="1010") else
							 SAMPLE  when (CurrentInstruction="0011") else
							 PRELOAD when (CurrentInstruction="0100") else
							 IDCODE  when (CurrentInstruction="0001") else --devid
							 UNKNOWN;


--ChangeTickIR: process (TRST,TCK)
--begin
--if (TRST='0' OR TRESET='0') then
--  InstrChange<='0';
--elsif (rising_edge(TCK)) then
--  a_CurrentInstruction<=CurrentInstruction;
--  if (a_CurrentInstruction/=CurrentInstruction) then
--    InstrChange<='1';
--  else
--    InstrChange<='0';
--  end if;
--end if;
--end process ChangeTickIR;
--End of instruction register part (hope so)
--***************************************************************************************************************************************************************************************************

--***************************************************************************************************************************************************************************************************
--Data register part
--processes:
--DataReg: selection of a register linked between TDI and TDO according to the current instruction
--***************************************************************************************************************************************************************************************************
DataReg: process (SHIFTDR,TRST,TRESET,CLOCKDR)
begin
if (TRST='0' OR TRESET='0') then
    BYP<=TDI;
    TDO<=BYP;
	 BScan<=(others=>'0');
	 DevID<="1010"; --jakies devid
elsif(SHIFTDR='1' and rising_edge(CLOCKDR)) then --to be verified whether it is a rising edge
  if (DecodedInstruction=BYPASS) then --bypass
    BYP<=TDI;
    TDO<=BYP;
  elsif (DecodedInstruction=EXTEST) then --boundary scan
    BScan<=TDI & BScan (3 downto 1);
    TDO<=BScan(0);
  elsif (DecodedInstruction=IDCODE) then --device id
    DevID<=TDI & DevID(3 downto 1);
    TDO<=DevID(0);
  end if;
end if;
end process DataReg;
--End of data register part
--***************************************************************************************************************************************************************************************************

end JTAGIDRegister_a;


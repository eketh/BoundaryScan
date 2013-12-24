library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
-- Here are all Cortex-related data.
use cortex_data.all;

entity CortexIDRegister is
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
end CortexIDRegister;

architecture Behavioral of CortexIDRegister is

type istate is (iUNKNOWN, iDEVID, iDPACC, iAPACC, iABORT, iBYPASS); --instructions possible @ Cortex M4

signal DecodedInstruction 								: istate;

--Instruction register signals:

signal InstructionShift                         : icode;
signal CurrentInstruction, a_CurrentInstruction : icode;

signal InstrChange                              : std_logic; -- auxiliary bit used when testing to indicate instruction change;

--Data register signals:
signal DevID												: std_logic_vector (IDlength downto 0); --device ID register
signal DPACC												: std_logic_vector (DPACCLength downto 0); 
signal APACC												: std_logic_vector (APACCLength downto 0);
signal ABORT												: std_logic_vector (AbortLength downto 0);
signal BYP													: std_logic; --bypass
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
-- ChangeTickIR: auxiliary signal going high for 1 TCK when instruction has changed. Used only for testing purposes.
-- Out of process: MUX decoding instruction code. Also auxiliary - if library containing instruction codes will be used, this may become unnecessary.
--***************************************************************************************************************************************************************************************************
IShift: process (TRST,TCK,TRESET,CLOCKIR,UPDATEIR)
begin
if (TRST='0' OR TRESET='0') then
  InstructionShift<=(others=>'0');
  CurrentInstruction<=(others=>'1'); --<=BYPASS_CODE;
elsif (rising_edge(CLOCKIR)) then
  if (SHIFTIR='1') then -- check whether it is the rising edge!!!
    InstructionShift<= TDI & InstructionShift(InstrLength downto 1);
    TDO<=InstructionShift(0);
  end if;
elsif (UPDATEIR='1') then -- same here 
  if (falling_edge(TCK)) then
    CurrentInstruction<=InstructionShift;  
  end if;
end if;
end process IShift;

--Decoded instruction: out of the process (just an optional info for us)
DecodedInstruction <= iBYPASS  when (CurrentInstruction=CodeBypass) else --bypass
							 iDEVID  when (CurrentInstruction=CodeIDCode) else --bscan
							 iDPACC  when (CurrentInstruction=CodeDPACC) else
							 iABORT  when (CurrentInstruction=CodeABORT) else
							 iAPACC when (CurrentInstruction=CodeAPACC) else
							 iUNKNOWN;


ChangeTickIR: process (TRST,TCK)
begin
if (TRST='0' OR TRESET='0') then
  InstrChange<='0';
elsif (rising_edge(TCK)) then
  a_CurrentInstruction<=CurrentInstruction;
  if (a_CurrentInstruction/=CurrentInstruction) then
    InstrChange<='1';
  else
    InstrChange<='0';
  end if;
end if;
end process ChangeTickIR;
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
	 DevID<=FixedId; --jakies devid
elsif(SHIFTDR='1' and rising_edge(CLOCKDR)) then --czy na pewno rising edge???
  if (DecodedInstruction=iBYPASS) then --bypass
    BYP<=TDI;
    TDO<=BYP;
  elsif (DecodedInstruction=iDPACC) then 
  --no idea. light some led? :P
  elsif (DecodedInstruction=iAPACC) then  
  --no idea. light some led? :P
  elsif (DecodedInstruction=iABORT) then  
  --no idea. light some led? :P  
  elsif (DecodedInstruction=iDEVID) then
    DevID<=TDI & DevID(IDlength downto 1);
    TDO<=DevID(0);
  end if;
end if;
end process DataReg;
--End of data register part
--***************************************************************************************************************************************************************************************************

end Behavioral;


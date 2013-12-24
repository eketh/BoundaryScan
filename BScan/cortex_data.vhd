--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package cortex_data is

constant IDlength    : integer:=31;
constant DPACCLength : integer:=34;
constant APACCLength : integer:=34;
constant AbortLength : integer:=34;
constant Instrlength : integer:=3;

--FixedId: actual ID of Cortex-M4 (0x4BA00477). Source: reference manual 
constant FixedId     : std_logic_vector (IDlength downto 0):="01001011101000000000010001110111"; 


subtype icode is std_logic_vector (InstrLength downto 0);
constant CodeBypass : icode:= "1111";
constant CodeIDCode : icode:= "1110";
constant CodeDPACC  : icode:= "1010";
constant CodeAPACC  : icode:= "1011";
constant CodeABORT  : icode:= "1000";

end cortex_data;

package body cortex_data is

end cortex_data;

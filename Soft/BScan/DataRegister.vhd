----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:04:59 10/27/2013 
-- Design Name: 
-- Module Name:    DataRegister - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DataRegister is
port(
PARAIR: in std_logic_vector (7 downto 0);
TCLK: in std_logic;
SHIFTDR: in std_logic;
CAPTUREDR: in std_logic; -- to jest wymagane?
TRESET: in std_logic;
TDI: in std_logic;
TDO: out std_logic

);
end DataRegister;

architecture Behavioral of DataRegister is

type registers is (BypassReg, BScanReg, DevIDReg);
signal CurrentRegister: registers;
signal DataRegister: std_logic_vector (7 downto 0);
constant DevIDValue: std_logic_vector (7 downto 0):= "10101010";

begin

RegChoice: process (TRESET)
begin
if (TRESET='1') then
  TDO<='0';
elsif (CurrentRegister = BypassReg) then
  TDO<=TDI;
end if;

end process RegChoice;

RegProcessing: process (TRESET, TCLK)
begin
if (TRESET='1') then
DataRegister<=(others=>'0');
  if (TCLK'event and TCLK='1') then --rising edge @ SHIFTDR state
    if (CAPTUREDR='1') then
	   DataRegister<=PARAIR;
	 elsif (SHIFTDR='1') then
      DataRegister<= TDI & DataRegister(8 downto 1);
	   TDO<=DataRegister (0);
    end if;
  end if;
end if;
end process RegProcessing;

end Behavioral;


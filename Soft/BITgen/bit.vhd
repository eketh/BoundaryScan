
-- Small project made only to generate a small .bit file that is to be placed within FPGA's memory.
--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bit is
    Port ( a : out  STD_LOGIC);
end bit;

architecture Behavioral of bit is
begin

a <= '1';

end Behavioral;


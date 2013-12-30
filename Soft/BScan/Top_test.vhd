-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY Top_test IS
  END Top_test;

  ARCHITECTURE Top_test_a OF Top_test IS 

component Top is
port(
TDI: in std_logic;
TMS: in std_logic;
TCK: in std_logic;
TDO: out std_logic;
reset: in std_logic
);
end component;

SIGNAL TDI, TDO, TMS, TCK, reset: std_logic;
			 
BEGIN


zagloba: Top PORT MAP(TDI=>TDI, TMS=>TMS, TCK=>TCK, TDO=>TDO, reset=>reset);

Clock:process
begin
TCK <= '0';
wait for 500 ps;
TCK <= '1';
wait for 500 ps;
end process Clock;
	

  --  Test Bench Statements
tb : PROCESS
BEGIN
TDI<='1';
TMS<='0';
reset<='0';
wait for 2 ns;
reset<='1';
TMS<='0';
wait for 1 ns;
TMS<='1';
wait for 9 ns;
TMS<='0';
wait for 1 ns;
TMS<='1';
wait for 2 ns;
TMS<='0';
wait for 3 ns;
TMS<='1';
wait for 1 ns;
TMS<='0';
wait for 4 ns;
TMS<='1';
wait for 1 ns;
TMS<='0';
wait for 4 ns;
TMS<='1';
wait for 2 ns;
TMS<='0';
wait for 2 ns;
assert false severity failure;
END PROCESS tb;


END Top_test_a;

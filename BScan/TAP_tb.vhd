---
--stary testbench tapa.
--wg niego tap dzialal bez problemów.
--NP

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY TAP_tb IS
END TAP_tb;
 
ARCHITECTURE TAP_tb_a OF TAP_tb IS 
 
    COMPONENT TAP
    PORT(
         TMS : IN  std_logic;
         TCK : IN  std_logic;
         TRST : IN  std_logic;
         CLOCKIR : OUT  std_logic;
         UPDATEIR : OUT  std_logic;
         SHIFTIR : OUT  std_logic;
         TRESET : OUT  std_logic;
         TSELECT : OUT  std_logic;
         ENABLE : OUT  std_logic;
         SHIFTDR : OUT  std_logic;
         UPDATEDR : OUT  std_logic;
         CLOCKDR : OUT  std_logic;
			--optional
			CAPTUREDR: OUT std_logic;
			CAPTUREIR: OUT std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal TMS : std_logic := '0';
   signal TCK : std_logic := '0';
   signal TRST : std_logic := '0';

 	--Outputs
   signal CLOCKIR : std_logic;
   signal UPDATEIR : std_logic;
   signal SHIFTIR : std_logic;
   signal TRESET : std_logic;
   signal TSELECT : std_logic;
   signal ENABLE : std_logic;
   signal SHIFTDR : std_logic;
   signal UPDATEDR : std_logic;
   signal CLOCKDR : std_logic;
	signal CAPTUREIR: std_logic;
	signal CAPTUREDR: std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TAP PORT MAP (
          TMS => TMS,
          TCK => TCK,
          TRST => TRST,
          CLOCKIR => CLOCKIR,
          UPDATEIR => UPDATEIR,
          SHIFTIR => SHIFTIR,
          TRESET => TRESET,
          TSELECT => TSELECT,
          ENABLE => ENABLE,
          SHIFTDR => SHIFTDR,
          UPDATEDR => UPDATEDR,
          CLOCKDR => CLOCKDR,
			 CAPTUREDR => CAPTUREDR,
			 CAPTUREIR => CAPTUREIR
        );

   -- Clock process definitions
   Clock:process
   begin
		TCK <= '0';
		wait for 500 ps;
		TCK <= '1';
		wait for 500 ps;
   end process Clock;
 
 --Test: z jotpega. Wynik: jak na jotpegu :)
	Test: process
	begin
	TRST<= '1';
   TMS<='1';
	wait for 5 ns;
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
	wait for 1 ns;
	TMS<='0';
	wait for 4 ns;

	TMS<='1';
	wait for 2 ns;
	TMS<='0';
	wait for 3 ns;	
	
	TMS<='1';
	wait for 5 ns;
	
	assert false severity failure;
	end process Test;


   end TAP_tb_a;

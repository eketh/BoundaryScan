
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY STMTest_tb IS
END STMTest_tb;
 
ARCHITECTURE behavior OF STMTest_tb IS 
 
    COMPONENT STMTest
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         trigger : IN  std_logic;
         TDO_jtag : IN  std_logic;
         TDI_jtag : OUT  std_logic;
         TMS : OUT  std_logic;
         TRST : OUT  std_logic;
         TCK : OUT  std_logic
        );
    END COMPONENT;
    

   signal clk : std_logic;
   signal reset : std_logic;
   signal trigger : std_logic;
   signal TDO_jtag : std_logic;
   signal TDI_jtag : std_logic;
   signal TMS : std_logic;
   signal TRST : std_logic;
   signal TCK : std_logic;

   constant clk_period : time := 1 ns;
 
BEGIN
   jacenty: STMTest PORT MAP (
          clk => clk,
          reset => reset,
          trigger => trigger,
          TDO_jtag => TDO_jtag,
          TDI_jtag => TDI_jtag,
          TMS => TMS,
          TRST => TRST,
          TCK => TCK
        );

   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
   reset<='0';
	tdo_jtag<='1';
	trigger<='0';
	wait for 2 ns;
	reset<='1';
	wait for 5 ns;
	trigger<='1';
	wait for 150 ns;
	assert false severity failure;
   end process;

END;

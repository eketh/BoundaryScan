--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:24:46 11/17/2013
-- Design Name:   
-- Module Name:   C:/!DYPLOM/BScan/ID_testbench.vhd
-- Project Name:  Boundary_scan
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: InstrDataRegister
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ID_testbench IS
END ID_testbench;
 
ARCHITECTURE behavior OF ID_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT InstrDataRegister
    PORT(
         TDI : IN  std_logic;
         TDO : OUT  std_logic;
         TRST : IN  std_logic;
         SHIFTIR : IN  std_logic;
         CLOCKIR : IN  std_logic;
         UPDATEIR : IN  std_logic;
         TRESET : IN  std_logic;
         SHIFTDR : IN  std_logic;
         CLOCKDR : IN  std_logic;
         UPDATEDR : IN  std_logic;
         CAPTUREDR : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal TDI : std_logic := '0';
   signal TRST : std_logic := '0';
   signal SHIFTIR : std_logic := '0';
   signal CLOCKIR : std_logic := '0';
   signal UPDATEIR : std_logic := '0';
   signal TRESET : std_logic := '0';
   signal SHIFTDR : std_logic := '0';
   signal CLOCKDR : std_logic := '0';
   signal UPDATEDR : std_logic := '0';
   signal CAPTUREDR : std_logic := '0';

 	--Outputs
   signal TDO : std_logic;

   -- Clock period definitions
   constant CLOCKIR_period : time := 10 ns;
   constant CLOCKDR_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: InstrDataRegister PORT MAP (
          TDI => TDI,
          TDO => TDO,
          TRST => TRST,
          SHIFTIR => SHIFTIR,
          CLOCKIR => CLOCKIR,
          UPDATEIR => UPDATEIR,
          TRESET => TRESET,
          SHIFTDR => SHIFTDR,
          CLOCKDR => CLOCKDR,
          UPDATEDR => UPDATEDR,
          CAPTUREDR => CAPTUREDR
        );

   -- Clock process definitions
   CLOCKIR_process :process
   begin
		CLOCKIR <= '0';
		wait for CLOCKIR_period/2;
		CLOCKIR <= '1';
		wait for CLOCKIR_period/2;
   end process;
 
   CLOCKDR_process :process
   begin
		CLOCKDR <= '0';
		wait for CLOCKDR_period/2;
		CLOCKDR <= '1';
		wait for CLOCKDR_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLOCKIR_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;

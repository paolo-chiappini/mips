--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:34:25 06/11/2023
-- Design Name:   
-- Module Name:   E:/Progetti Xilinx/mips/DEC_TB.vhd
-- Project Name:  MIPS
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DEC
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
 
ENTITY DEC_TB IS
END DEC_TB;
 
ARCHITECTURE behavior OF DEC_TB IS 
 
    COMPONENT DEC
    PORT(
         DEC_IN : IN  std_logic_vector(4 downto 0);
         DEC_OUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    
   signal DEC_IN : std_logic_vector(4 downto 0) := (others => '0');
	signal DEC_OUT : std_logic_vector(31 downto 0);
	
	constant HALF_CLOCK : time := 10 ns;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DEC PORT MAP (
          DEC_IN => DEC_IN,
          DEC_OUT => DEC_OUT
        );

   process
   begin		
		DEC_IN <= "00000";
		wait for HALF_CLOCK;
		
		DEC_IN <= "00001";
		wait for HALF_CLOCK;
		
		DEC_IN <= "00010";
		wait for HALF_CLOCK;
		
		DEC_IN <= "00011";
		wait for HALF_CLOCK;
		
		DEC_IN <= "00100";
		wait for HALF_CLOCK;
		
		DEC_IN <= "00101";
		wait for HALF_CLOCK;
		DEC_IN <= "11111";
		wait for HALF_CLOCK;
		DEC_IN <= "11110";
      wait;
   end process;

END;

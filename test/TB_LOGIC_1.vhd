library ieee;
use ieee.std_logic_1164.all;
 
entity TB_LOGIC_1 is
end TB_LOGIC_1;
 
architecture behavior of TB_LOGIC_1 is 
 
    COMPONENT LOGIC_1
    PORT(
         A : IN  std_logic;
         B : IN  std_logic;
         A_INV : IN  std_logic;
         B_INV : IN  std_logic;
         A_AND_B : OUT  std_logic;
         A_OR_B : OUT  std_logic;
         A_XOR_B : OUT  std_logic
        );
    END COMPONENT;
    
   --Inputs
   signal A : std_logic;
   signal B : std_logic;
   signal A_INV : std_logic;
   signal B_INV : std_logic;

 	--Outputs
   signal A_AND_B : std_logic;
   signal A_OR_B : std_logic;
   signal A_XOR_B : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LOGIC_1 PORT MAP (
          A => A,
          B => B,
          A_INV => A_INV,
          B_INV => B_INV,
          A_AND_B => A_AND_B,
          A_OR_B => A_OR_B,
          A_XOR_B => A_XOR_B
        );

   -- Stimulus process
   stim_proc: process
   begin		
      A_INV <= '0'; 
      B_INV <= '0'; 

      A <= '0'; 
      B <= '0'; 
      wait for 50 ns;  

      A <= '1'; 
      wait for 50 ns; 

      A <= '0'; 
      B <= '1'; 
      wait for 50 ns; 

      A <= '1'; 
      wait for 50 ns;

      ----

      A_INV <= '1'; 
      B_INV <= '0'; 

      A <= '0'; 
      B <= '0'; 
      wait for 50 ns;  

      A <= '1'; 
      wait for 50 ns; 

      A <= '0'; 
      B <= '1'; 
      wait for 50 ns; 

      A <= '1'; 
      wait for 50 ns;

      ----

      A_INV <= '0'; 
      B_INV <= '1'; 

      A <= '0'; 
      B <= '0'; 
      wait for 50 ns;  

      A <= '1'; 
      wait for 50 ns; 

      A <= '0'; 
      B <= '1'; 
      wait for 50 ns; 

      A <= '1'; 
      wait for 50 ns;

		----

      A_INV <= '1'; 
      B_INV <= '1'; 

      A <= '0'; 
      B <= '0'; 
      wait for 50 ns;  

      A <= '1'; 
      wait for 50 ns; 

      A <= '0'; 
      B <= '1'; 
      wait for 50 ns; 

      A <= '1'; 
      wait;
   end process;

end;

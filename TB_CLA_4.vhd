LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_CLA_4 IS
END TB_CLA_4;
 
ARCHITECTURE behavior OF TB_CLA_4 IS 

    COMPONENT CLA_4
    PORT(
         CIN : IN  std_logic;
         P : IN  std_logic_vector(3 downto 0);
         G : IN  std_logic_vector(3 downto 0);
         C : OUT  std_logic_vector(3 downto 0);
         COUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CIN : std_logic;
   signal P : std_logic_vector(3 downto 0);
   signal G : std_logic_vector(3 downto 0);

 	--Outputs
   signal C : std_logic_vector(3 downto 0);
   signal COUT : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CLA_4 PORT MAP (
          CIN => CIN,
          P => P,
          G => G,
          C => C,
          COUT => COUT
        );

   -- Stimulus process
   stim_proc: process
   begin		
      CIN <= '0'; 
      P <= "0000"; 
      G <= "0000"; 
      wait for 100 ns; 

      CIN <= '1'; 
      wait for 100 ns; 

      CIN <= '0'; 
      P <= "0110"; 
      G <= "1011"; 
      wait for 100 ns; 

      CIN <= '1'; 
      wait for 100 ns; 

      CIN <= '0'; 
      P <= "0010"; 
      G <= "0100"; 
      wait for 100 ns; 

      CIN <= '1'; 
      wait for 100 ns; 

      CIN <= '0'; 
      P <= "1111"; 
      G <= "1111"; 
      wait for 100 ns; 

      CIN <= '1'; 
      wait;
   end process;

END;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_LOG_SHIFTER IS
END TB_LOG_SHIFTER;
 
ARCHITECTURE behavior OF TB_LOG_SHIFTER IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LOG_SHIFTER_32
    PORT(
         X : IN  std_logic_vector(31 downto 0);
         SHAMT : IN  std_logic_vector(4 downto 0);
         SHIFT_OP : IN  std_logic_vector(1 downto 0);
         Y : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic_vector(31 downto 0);
   signal SHAMT : std_logic_vector(4 downto 0);
   signal SHIFT_OP : std_logic_vector(1 downto 0);

 	--Outputs
   signal Y : std_logic_vector(31 downto 0);
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LOG_SHIFTER_32 PORT MAP (
          X => X,
          SHAMT => SHAMT,
          SHIFT_OP => SHIFT_OP,
          Y => Y
        );

   -- Stimulus process
   stim_proc: process
   begin		
      X <= x"B0F09090"; 
      SHAMT <= "11111"; 
      SHIFT_OP <= "00"; 
      wait for 100 ns; 

      SHAMT <= "00000"; 
      SHIFT_OP <= "01"; 
      wait for 100 ns; 

      SHAMT <= "01010";
      wait for 100 ns; 
      
      SHIFT_OP <= "10"; 
      wait for 100 ns; 

      SHIFT_OP <= "11"; 
      wait for 100 ns; 

      SHIFT_OP <= "10"; 
      X <= x"00F0B090"; 
      wait for 100 ns; 

      SHIFT_OP <= "11"; 
      wait;
   end process;

END;

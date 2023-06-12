LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_DRCU_32 IS
END TB_DRCU_32;
 
ARCHITECTURE behavior OF TB_DRCU_32 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DRCU_N
    PORT(
         X : IN  std_logic_vector(31 downto 0);
         INVERT : IN  std_logic;
         Y : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic_vector(31 downto 0);
   signal INVERT : std_logic;

 	--Outputs
   signal Y : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DRCU_N PORT MAP (
          X => X,
          INVERT => INVERT,
          Y => Y
        );

   -- Stimulus process
   stim_proc: process
   begin		
      X <= x"F0F000AB"; 
      INVERT <= '0'; 
      wait for 200 ns; 

      INVERT <= '1'; 
      wait;
   end process;

END;

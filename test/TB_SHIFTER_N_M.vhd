LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_SHIFTER_N_M IS
END TB_SHIFTER_N_M;
 
ARCHITECTURE behavior OF TB_SHIFTER_N_M IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SHIFTER_N_M
    GENERIC (
         N : INTEGER := 32;
         M : INTEGER := 1
        ); 
    PORT(
         X : IN  std_logic_vector(31 downto 0);
         ENABLE : IN  std_logic;
         FILL : IN  std_logic;
         Y : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic_vector(31 downto 0);
   signal ENABLE : std_logic;
   signal FILL : std_logic;

 	--Outputs
   signal Y : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SHIFTER_N_M 
        GENERIC MAP (
          N => 32, 
          M => 4
        )
        PORT MAP (
          X => X,
          ENABLE => ENABLE,
          FILL => FILL,
          Y => Y
        );

   -- Stimulus process
   stim_proc: process
   begin		
      X <= x"B0F09092"; 
      ENABLE <= '0'; 
      FILL <= '0'; 
      wait for 200 ns; 

      ENABLE <= '1'; 
      wait for 200 ns; 

      FILL <= '1'; 
		wait for 200 ns; 
		
		ENABLE <= '0'; 
      wait;
   end process;

END;

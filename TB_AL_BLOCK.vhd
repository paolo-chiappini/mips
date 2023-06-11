LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_AL_BLOCK IS
END TB_AL_BLOCK;
 
ARCHITECTURE behavior OF TB_AL_BLOCK IS 
 
   constant SUB_MODS : integer := 8;
   constant BITS : integer := SUB_MODS * 4;  

    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT AL_BLOCK_4N
	 GENERIC ( SUB_MODULES : INTEGER ); 
    PORT(
         A : IN  std_logic_vector(BITS - 1 downto 0);
         B : IN  std_logic_vector(BITS - 1 downto 0);
         CIN : IN  std_logic;
         A_INV : IN  std_logic;
         B_INV : IN  std_logic;
         S : OUT  std_logic_vector(BITS - 1 downto 0);
         COUT : OUT  std_logic;
         A_AND_B : OUT  std_logic_vector(BITS - 1 downto 0);
         A_OR_B : OUT  std_logic_vector(BITS - 1 downto 0);
         A_XOR_B : OUT  std_logic_vector(BITS - 1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(BITS - 1 downto 0);
   signal B : std_logic_vector(BITS - 1 downto 0);
   signal CIN : std_logic;
   signal A_INV : std_logic;
   signal B_INV : std_logic;

 	--Outputs
   signal S : std_logic_vector(BITS - 1 downto 0);
   signal COUT : std_logic;
   signal A_AND_B : std_logic_vector(BITS - 1 downto 0);
   signal A_OR_B : std_logic_vector(BITS - 1 downto 0);
   signal A_XOR_B : std_logic_vector(BITS - 1 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: AL_BLOCK_4N 
      generic map ( SUB_MODULES => SUB_MODS ) 
      PORT MAP (
         A => A,
         B => B,
         CIN => CIN,
         A_INV => A_INV,
         B_INV => B_INV,
         S => S,
         COUT => COUT,
         A_AND_B => A_AND_B,
         A_OR_B => A_OR_B,
         A_XOR_B => A_XOR_B
      );

   -- Stimulus process
   stim_proc: process
   begin		

      A_INV <= '0'; 
      B_INV <= '0'; 
      CIN <= '0'; 
      A <= (others => '0'); 
      B <= (others => '0'); 
      wait for 100 ns;	

		
      A <= "11111111111111111111111101010100"; -- A = -172
		B <= "00000000000000000000000001010011"; -- B = 83 
		-- A + B expected -89
		wait for 100 ns; 
		
		CIN <= '1'; 
		B_INV <= '1'; 
		-- A - B expected -255
		wait for 100 ns;
		
		CIN <= '1'; 
		A_INV <= '1';		
		B_INV <= '0'; 
		-- (-A) + B expected 255
		wait for 100 ns;
		
		A <= "00000000000000000000000000101000"; -- A = 40; 
		CIN <= '0'; 
		A_INV <= '0';	
		-- A + B expected 123
		wait for 100 ns; 
		
		B_INV <= '1'; 
		CIN <= '1'; 
		-- A - B expected -43 
		
      wait;
   end process;

END;

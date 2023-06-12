LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY TB_ALU_32 IS
END TB_ALU_32;
 
ARCHITECTURE behavior OF TB_ALU_32 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU_32
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         ALU_OP : IN  std_logic_vector(5 downto 0);
         C : OUT  std_logic_vector(31 downto 0);
         ZERO : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_OP : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal C : std_logic_vector(31 downto 0);
   signal ZERO : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU_32 PORT MAP (
          A => A,
          B => B,
          ALU_OP => ALU_OP,
          C => C,
          ZERO => ZERO
        );

   -- Stimulus process
   stim_proc: process
   begin		
		
      A <= x"0000AAAA"; 
		B <= x"00FF00FF"; 
      wait for 100 ns;	
		
		ALU_OP <= "001100"; 
		wait for 100 ns;

		ALU_OP <= "011100"; 
		wait for 100 ns; 
		
		ALU_OP <= "000001"; 
		wait for 100 ns; 
		
		ALU_OP <= "000010"; 
		wait for 100 ns; 
		
		ALU_OP <= "000011"; 
		wait for 100 ns; 
		
		ALU_OP <= "011101"; 
		wait for 100 ns; 
		
		ALU_OP <= "010101"; 
		wait for 100 ns;
		
      -- undefined operation
		ALU_OP <= "000111"; 
      wait for 100 ns; 

      ----------------------
		
		-- unisgned
		A <= x"0000000F"; 
		B <= x"0000000A";
		ALU_OP <= "010101"; 
		wait for 100 ns; 
		
		-- singed 
		ALU_OP <= "011101"; 
		wait for 100 ns; 
		
		----------------------

		-- unsigned 
		B <= x"0000000F"; 
		A <= x"0000000A";
		ALU_OP <= "010101"; 
		wait for 100 ns; 
		
		-- signed 
		ALU_OP <= "011101"; 
		wait for 100 ns; 
		
		----------------------
		
		-- unsigned 
		B <= x"0000000A"; 
		A <= x"0000000A";
		ALU_OP <= "010101"; 
		wait for 100 ns; 
		
		-- signed 
		ALU_OP <= "011101"; 
		wait for 100 ns; 
		
		----------------------

		-- unsigned 
		B <= x"F000000A"; 
		A <= x"0000000A";
		ALU_OP <= "010101"; 
		wait for 100 ns; 
		
		-- signed 
		ALU_OP <= "011101"; 
		wait for 100 ns; 
		
		----------------------
		
		-- unsigned 
		B <= x"0000000A"; 
		A <= x"F000000A";
		ALU_OP <= "010101"; 
		wait for 100 ns; 
		
		-- signed 
		ALU_OP <= "011101"; 
		wait for 100 ns; 
		
		----------------------
		
		-- unsigned 
		B <= x"F000000F"; 
		A <= x"F000000A";
		ALU_OP <= "010101"; 
		wait for 100 ns; 
		
		-- signed 
		ALU_OP <= "011101"; 
		wait for 100 ns; 
		
		----------------------
		
		-- unsigned 
		B <= x"F000000A"; 
		A <= x"F000000F";
		ALU_OP <= "010101"; 
		wait for 100 ns; 
		
		-- signed 
		ALU_OP <= "011101"; 
		wait for 100 ns; 
		
		----------------------
      wait;
   end process;

END;

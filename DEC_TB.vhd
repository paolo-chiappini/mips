
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY DEC_TB IS
END DEC_TB;
 
ARCHITECTURE behavior OF DEC_TB IS 
	constant N : positive := 5;
   signal DEC_IN : std_logic_vector(0 to N-1);
   signal DEC_OUT : std_logic_vector(0 to (2**N) - 1);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.DEC(RTL)
	GENERIC MAP(
		INPUT_SIZE => N
	)
	PORT MAP (
      DEC_IN => DEC_IN,
		DEC_OUT => DEC_OUT
   );

   process
   begin
		DEC_IN <= "00000";
		
		wait for 10 ns;
		
		DEC_IN <= "00001";
		
		wait for 10 ns;
		
		DEC_IN <= "00010";
		
		wait for 10 ns;
		
		DEC_IN <= "00011";
		
		wait for 10 ns;
		
		DEC_IN <= "00100";
		
		wait for 10 ns;
		
		DEC_IN <= "00101";
		
		wait for 10 ns;
		
		DEC_IN <= "11111";
		
		wait;
   end process;

END;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity DEC is
	generic(
		INPUT_SIZE : integer := 5
	);
	port( 
		DEC_IN: in std_logic_vector(INPUT_SIZE - 1 downto 0);
		DEC_OUT: out std_logic_vector((2**INPUT_SIZE) - 1 downto 0)
	); 
end DEC;

architecture RTL of DEC is

begin
	process(DEC_IN)
	begin
		DEC_OUT <= (others => '0');
		DEC_OUT(to_integer(unsigned(DEC_IN))) <= '1';
	end process;
end RTL;


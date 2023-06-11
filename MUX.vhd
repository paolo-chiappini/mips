
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package MUX_PKG is
	type SLV_ARRAY is array (0 to 31) of std_logic_vector(31 downto 0);
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use work.MUX_PKG.ALL;

entity MUX is
	port(
		MUX_IN : in SLV_ARRAY;
		SEL_IN : in std_logic_vector(4 downto 0);
		
		MUX_OUT : out std_logic_vector(31 downto 0)
	);
end MUX;

architecture RTL of MUX is
begin
	MUX_OUT <= MUX_IN(to_integer(unsigned(SEL_IN)));
end RTL;


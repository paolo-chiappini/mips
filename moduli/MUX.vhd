
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package MUX_PKG is
	type SLV_ARRAY is array(natural range<>) of std_logic_vector(31 downto 0);
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use work.MUX_PKG.ALL;

entity MUX is
	generic(
		SEL_SIZE : integer := 5
	);
	port(
		MUX_IN : in SLV_ARRAY(0 to (2**SEL_SIZE)-1);
		SEL_IN : in std_logic_vector(SEL_SIZE - 1 downto 0);
		
		MUX_OUT : out std_logic_vector(31 downto 0)
	);
end MUX;

architecture RTL of MUX is
begin
	MUX_OUT <= MUX_IN(to_integer(unsigned(SEL_IN)));
end RTL;


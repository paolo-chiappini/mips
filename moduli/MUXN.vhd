library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--perdoname madre por mi vida loca
entity MUXN is
	generic(
		INPUT_SIZE : integer := 32
	);
	port(
		IN0, IN1, IN2, IN3, IN4, IN5, IN6, IN7,
		IN8, IN9, IN10, IN11, IN12, IN13, IN14, IN15,
		IN16, IN17, IN18, IN19, IN20, IN21, IN22, IN23,
		IN24, IN25, IN26, IN27, IN28, IN29, IN30, IN31 : in std_logic_vector(INPUT_SIZE-1 downto 0);
		
		SEL_IN : in std_logic_vector(4 downto 0);
		MUX_OUT : out std_logic_vector(INPUT_SIZE-1 downto 0)
	);
end MUXN;

architecture RTL of MUXN is
begin
	with SEL_IN select
		MUX_OUT <= IN0  when "00000",
					  IN1  when "00001",
					  IN2  when "00010",
					  IN3  when "00011",
					  IN4  when "00100",
					  IN5  when "00101",
					  IN6  when "00110",
					  IN7  when "00111",
					  
					  IN8  when "01000",
					  IN9  when "01001",
					  IN10 when "01010",
					  IN11 when "01011",
					  IN12 when "01100",
					  IN13 when "01101",
					  IN14 when "01110",
					  IN15 when "01111",
					  
					  IN16 when "10000",
					  IN17 when "10001",
					  IN18 when "10010",
					  IN19 when "10011",
					  IN20 when "10100",
					  IN21 when "10101",
					  IN22 when "10110",
					  IN23 when "10111",
					  
					  IN24 when "11000",
					  IN25 when "11001",
					  IN26 when "11010",
					  IN27 when "11011",
					  IN28 when "11100",
					  IN29 when "11101",
					  IN30 when "11110",
					  IN31 when "11111",
					  (others => '-') when others;
end RTL;


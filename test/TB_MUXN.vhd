
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY TB_MUXN IS
END TB_MUXN;
 
ARCHITECTURE behavior OF TB_MUXN IS 
 
    

   --Inputs
   signal IN0  : std_logic_vector(31 downto 0) := x"00000000";
   signal IN1  : std_logic_vector(31 downto 0) := x"00000010";
   signal IN2  : std_logic_vector(31 downto 0) := x"00000200";
   signal IN3  : std_logic_vector(31 downto 0) := x"00003000";
   signal IN4  : std_logic_vector(31 downto 0) := x"00040000";
   signal IN5  : std_logic_vector(31 downto 0) := x"00500000";
   signal IN6  : std_logic_vector(31 downto 0) := x"06000000";
   signal IN7  : std_logic_vector(31 downto 0) := x"70000000";
   signal IN8  : std_logic_vector(31 downto 0) := x"00000008";
   signal IN9  : std_logic_vector(31 downto 0) := x"00000090";
   signal IN10 : std_logic_vector(31 downto 0) := x"00000A00";
   signal IN11 : std_logic_vector(31 downto 0) := x"0000B000";
   signal IN12 : std_logic_vector(31 downto 0) := x"000C0000";
   signal IN13 : std_logic_vector(31 downto 0) := x"00D00000";
   signal IN14 : std_logic_vector(31 downto 0) := x"0E000000";
   signal IN15 : std_logic_vector(31 downto 0) := x"F0000000";
   signal IN16 : std_logic_vector(31 downto 0) := x"11111111";
   signal IN17 : std_logic_vector(31 downto 0) := x"22222222";
   signal IN18 : std_logic_vector(31 downto 0) := x"33333333";
   signal IN19 : std_logic_vector(31 downto 0) := x"44444444";
   signal IN20 : std_logic_vector(31 downto 0) := x"55555555";
   signal IN21 : std_logic_vector(31 downto 0) := x"66666666";
   signal IN22 : std_logic_vector(31 downto 0) := x"77777777";
   signal IN23 : std_logic_vector(31 downto 0) := x"88888888";
   signal IN24 : std_logic_vector(31 downto 0) := x"99999999";
   signal IN25 : std_logic_vector(31 downto 0) := x"AAAAAAAA";
   signal IN26 : std_logic_vector(31 downto 0) := x"BBBBBBBB";
   signal IN27 : std_logic_vector(31 downto 0) := x"CCCCCCCC";
   signal IN28 : std_logic_vector(31 downto 0) := x"DDDDDDDD";
   signal IN29 : std_logic_vector(31 downto 0) := x"EEEEEEEE";
   signal IN30 : std_logic_vector(31 downto 0) := x"FFFFFFFF";
   signal IN31 : std_logic_vector(31 downto 0) := x"ABCDEF01";
   signal SEL_IN : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal MUX_OUT : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   DEC: entity work.MUXN(RTL)
	GENERIC MAP(
		INPUT_SIZE => 32
	)
	PORT MAP (
          IN0 => IN0,
          IN1 => IN1,
          IN2 => IN2,
          IN3 => IN3,
          IN4 => IN4,
          IN5 => IN5,
          IN6 => IN6,
          IN7 => IN7,
          IN8 => IN8,
          IN9 => IN9,
          IN10 => IN10,
          IN11 => IN11,
          IN12 => IN12,
          IN13 => IN13,
          IN14 => IN14,
          IN15 => IN15,
          IN16 => IN16,
          IN17 => IN17,
          IN18 => IN18,
          IN19 => IN19,
          IN20 => IN20,
          IN21 => IN21,
          IN22 => IN22,
          IN23 => IN23,
          IN24 => IN24,
          IN25 => IN25,
          IN26 => IN26,
          IN27 => IN27,
          IN28 => IN28,
          IN29 => IN29,
          IN30 => IN30,
          IN31 => IN31,
          SEL_IN => SEL_IN,
          MUX_OUT => MUX_OUT
        );

	process
	begin
	
		for I in 0 to 31 loop
			SEL_IN <= std_logic_vector(to_unsigned(I, SEL_IN'length));
			wait for 10 ns;
		end loop;
		wait;
	end process;

END;

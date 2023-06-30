
use work.MUX_PKG.ALL;

package REGFILE_PKG is
  signal REGS_DATA : SLV_ARRAY(0 to 31);
end package REGFILE_PKG  ; 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MUX_PKG.ALL;
use work.REGFILE_PKG.ALL;

entity REGFILE is
    port(
        WR_REG: in std_logic;
        CLK: in std_logic;
        RST: in std_logic;

        DIN: in std_logic_vector(0 to 31);
        RS: in std_logic_vector(0 to 4);
        RT: in std_logic_vector(0 to 4);
        RD: in std_logic_vector(0 to 4);

        D0: out std_logic_vector(0 to 31);
        D1: out std_logic_vector(0 to 31)
    );
end REGFILE;

architecture RTL of REGFILE is
   --type SLV_ARRAY is array (0 to 31) of std_logic_vector(31 downto 0);
	signal DEC_OUT : std_logic_vector(31 downto 0);
	signal ENABLE : std_logic_vector(31 downto 0);
	signal REG_OUT : SLV_ARRAY(0 to 31);
	signal PRESETS : SLV_ARRAY(0 to 31);
begin
   -- decoder
	DEC: entity work.DEC(RTL)
	port map(
      DEC_IN => RD,
		DEC_OUT => DEC_OUT
   );
	
   -- registers	
	REGISTERS: for I in 31 downto 0 generate
		
		ENABLE(I) <= DEC_OUT(I) and WR_REG;
		
		PRESETS(I) <= x"00000300" when I = 28 else
			           x"000003FC" when I = 29 else
					     x"00000000";
						  
		REG: entity work.REG_N(RTL)
		generic map(
			N => 32
		)
		port map(
		    CLK => CLK,
          RST => RST,
			 PRESET => PRESETS(I),
          EN => ENABLE(I),
          DIN => DIN,
          DOUT => REG_OUT(I)
		);
	end generate;
	
	-- multiplexers
	MUX0: entity work.MUXN(RTL) -- RS -> D0
	generic map(
		INPUT_SIZE => 32
	)
	port map(
		IN0  => REG_OUT(0),
		IN1  => REG_OUT(1),
		IN2  => REG_OUT(2),
		IN3  => REG_OUT(3),
		IN4  => REG_OUT(4),
		IN5  => REG_OUT(5),
		IN6  => REG_OUT(6),
		IN7  => REG_OUT(7),
		IN8  => REG_OUT(8),
		IN9  => REG_OUT(9),
		IN10 => REG_OUT(10),
		IN11 => REG_OUT(11),
		IN12 => REG_OUT(12),
		IN13 => REG_OUT(13),
		IN14 => REG_OUT(14),
		IN15 => REG_OUT(15),
		IN16 => REG_OUT(16),
		IN17 => REG_OUT(17),
		IN18 => REG_OUT(18),
		IN19 => REG_OUT(19),
		IN20 => REG_OUT(20),
		IN21 => REG_OUT(21),
		IN22 => REG_OUT(22),
		IN23 => REG_OUT(23),
		IN24 => REG_OUT(24),
		IN25 => REG_OUT(25),
		IN26 => REG_OUT(26),
		IN27 => REG_OUT(27),
		IN28 => REG_OUT(28),
		IN29 => REG_OUT(29),
		IN30 => REG_OUT(30),
		IN31 => REG_OUT(31),
		SEL_IN => RS,
		MUX_OUT => D0
	);
	
	MUX1: entity work.MUXN(RTL) -- RT -> D1
	generic map(
		INPUT_SIZE => 32
	)
	port map(
		IN0  => REG_OUT(0),
		IN1  => REG_OUT(1),
		IN2  => REG_OUT(2),
		IN3  => REG_OUT(3),
		IN4  => REG_OUT(4),
		IN5  => REG_OUT(5),
		IN6  => REG_OUT(6),
		IN7  => REG_OUT(7),
		IN8  => REG_OUT(8),
		IN9  => REG_OUT(9),
		IN10 => REG_OUT(10),
		IN11 => REG_OUT(11),
		IN12 => REG_OUT(12),
		IN13 => REG_OUT(13),
		IN14 => REG_OUT(14),
		IN15 => REG_OUT(15),
		IN16 => REG_OUT(16),
		IN17 => REG_OUT(17),
		IN18 => REG_OUT(18),
		IN19 => REG_OUT(19),
		IN20 => REG_OUT(20),
		IN21 => REG_OUT(21),
		IN22 => REG_OUT(22),
		IN23 => REG_OUT(23),
		IN24 => REG_OUT(24),
		IN25 => REG_OUT(25),
		IN26 => REG_OUT(26),
		IN27 => REG_OUT(27),
		IN28 => REG_OUT(28),
		IN29 => REG_OUT(29),
		IN30 => REG_OUT(30),
		IN31 => REG_OUT(31),
		SEL_IN => RT,
		MUX_OUT => D1
	);
	
	REGS_DATA <= REG_OUT;
	
end RTL;

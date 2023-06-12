
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.MUX_PKG.ALL;

entity REGFILE is
    port(
        WRREG: in std_logic;
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
	signal REG_OUT : SLV_ARRAY;
begin
   -- decoder
	DEC: entity work.DEC(RTL)
	generic map(
		INPUT_SIZE => 5
	)
	port map(
      DEC_IN => RD,
		DEC_OUT => DEC_OUT
   );
	
   -- registers	
	REGISTERS: for I in 31 downto 0 generate
		
		ENABLE(I) <= DEC_OUT(I) and WRREG;
		
		REG: entity work.REG32(RTL)
		port map(
		    CLK => CLK,
          RST => RST,
          EN => ENABLE(I),
          DIN => DIN,
          DOUT => REG_OUT(I)
		);
	end generate;
	
	-- multiplexers
	MUX0: entity work.MUX(RTL)
	port map(
		MUX_IN => REG_OUT,
		SEL_IN => RS,
		MUX_OUT => D0
	);
	MUX1: entity work.MUX(RTL)
	port map(
		MUX_IN => REG_OUT,
		SEL_IN => RT,
		MUX_OUT => D1
	);
	
	
end RTL;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity REG_UNIT is
	port(
        CLK: in std_logic;
        RST: in std_logic;
		  
		  WR_REG: in std_logic;
        JAL: in std_logic;
		  DST_REG: in std_logic;

        PC_IN: in std_logic_vector(0 to 31); -- Data from Program Counter
		  WB_IN: in std_logic_vector(0 to 31); -- Data from Writeback
		  
        RS: in std_logic_vector(0 to 4);
        RT: in std_logic_vector(0 to 4);
        RD: in std_logic_vector(0 to 4);

        D0: out std_logic_vector(0 to 31);
        D1: out std_logic_vector(0 to 31)
    );
end REG_UNIT;

architecture RTL of REG_UNIT is
signal DIN : std_logic_vector(0 to 31);
signal RD_FROM_ISTR : std_logic_vector(0 to 4); -- Register address from instruction
signal RD_TEMP: std_logic_vector(0 to 4);
begin
	REG_FILE: entity work.REGFILE(RTL)
	port map(
        WR_REG => WR_REG,
        CLK => CLK,
        RST => RST,
        DIN => DIN,
        RS => RS,
        RT => RT,
        RD => RD_TEMP,
        D0 => D0,
        D1 => D1
   );
	
	DIN <= PC_IN when JAL = '1' else 
			 WB_IN;
			 
	RD_TEMP <= "11111" when JAL = '1' else
	           RD_FROM_ISTR;
				  
	RD_FROM_ISTR <= RD when DST_REG = '1' else
	           RT;
end RTL;


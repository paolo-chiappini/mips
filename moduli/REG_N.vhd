LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY REG_N IS
	 generic(
		  N: integer := 32
	 );
    port(
        CLK: in std_logic;
        RST: in std_logic;
		  PRESET: std_logic_vector(0 to N-1) := (others => '0');
        EN: in std_logic;

        DIN: in std_logic_vector(0 to N-1);
        DOUT: out std_logic_vector(0 to N-1)
    );
END REG_N;

ARCHITECTURE RTL of REG_N IS
    signal data: std_logic_vector(0 to N-1);
BEGIN
    DOUT <= data;
    
    process(CLK)
    begin
        if(CLK'event and CLK = '1') then
            if (RST = '1') then
                data <= PRESET;
            else
                if (EN = '1') then
						data <= DIN;
					 end if;
            end if;
        end if;
    end process;
END RTL;


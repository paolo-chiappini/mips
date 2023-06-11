LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY REG32 IS
    port(
        CLK: in std_logic;
        RST: in std_logic;
        EN: in std_logic;

        DIN: in std_logic_vector(0 to 31);
        DOUT: out std_logic_vector(0 to 31)
    );
END REG32;

ARCHITECTURE RTL of REG32 IS
    signal data: std_logic_vector(0 to 31);
BEGIN
    DOUT <= data;
    
    process(CLK)
    begin
        if(CLK'event and CLK = '1') then
            if (RST = '1') then
                data <= (others => '0');
            else
                if (EN = '1') then
						data <= DIN;
					 end if;
            end if;
        end if;
    end process;
END RTL;


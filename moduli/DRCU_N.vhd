library ieee;
use ieee.std_logic_1164.all;

entity DRCU_N is
    generic ( N : integer := 32 ); 
    port (
        X      : in  std_logic_vector(N - 1 downto 0);
        INVERT : in  std_logic; 
        Y      : out std_logic_vector(N - 1 downto 0)
    ); 
end DRCU_N;

architecture RTL of DRCU_N is
begin
    INV_SIG : for I in X'range generate 
        Y(I) <= X(I) when INVERT = '0' else X(N - 1 - I); 
    end generate INV_SIG; 
end RTL;


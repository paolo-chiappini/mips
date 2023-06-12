library ieee;
use ieee.std_logic_1164.ALL;

entity SHIFTER_N_M is
    generic ( 
        N : integer := 32; -- number of bits 
        M : integer := 1   -- fixed shift amount 
    ); 
    port (
        X       : in  std_logic_vector(N - 1 downto 0);
        ENABLE  : in  std_logic; 
        FILL    : in  std_logic; -- bit used to fill the shifted spaces  
        Y       : out std_logic_vector(N - 1 downto 0)
    );
end SHIFTER_N_M;

architecture RTL of SHIFTER_N_M is
begin
    GEN_SIGS : for I in M to N - 1 generate
        Y(I - M) <= X(I) when ENABLE = '1' else X(I - M);   
    end generate GEN_SIGS;
    
    GEN_FILL : for I in N - M to N - 1 generate
        Y(I) <= FILL when ENABLE = '1' else X(I);  
    end generate GEN_FILL; 
end RTL;


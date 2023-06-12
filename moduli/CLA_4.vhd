library ieee;
use ieee.std_logic_1164.all;

entity CLA_4 is
    port (
        CIN  : in  std_logic; 
        P    : in  std_logic_vector(3 downto 0);
        G    : in  std_logic_vector(3 downto 0);  
        C    : out std_logic_vector(3 downto 0); 
        COUT : out std_logic  -- overflow carry
    );
end CLA_4;

architecture RTL of CLA_4 is
    
begin
    C(0) <= CIN; 
    C(1) <= G(0) or (CIN and P(0)); 
    C(2) <= G(1) or (G(0) and P(1)) or (CIN and P(0) and P(1)); 
    C(3) <= G(2) or (G(1) and P(2)) or (G(0) and P(1) and P(2)) or (CIN and P(0) and P(1) and P(2)); 
    COUT <= G(3) or (G(2) and P(3)) or (G(1) and P(2) and P(3)) or (G(0) and P(1) and P(2) and P(3)) or (CIN and P(0) and P(1) and P(2) and P(3)); 
end RTL;


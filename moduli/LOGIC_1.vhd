library ieee;
use ieee.std_logic_1164.all;

entity LOGIC_1 is
    port (
        A       : in  std_logic; 
        B       : in  std_logic; 
        A_INV   : in  std_logic; 
        B_INV   : in  std_logic; 
        A_AND_B : out std_logic; -- becomes A nor B if A_INV = B_INV = 1
        A_OR_B  : out std_logic; -- becomes A nand B if A_INV = B_INV = 1
        A_XOR_B : out std_logic  -- becomes A xnor B if A_INV = B_INV = 1
    );
end LOGIC_1;

architecture RTL of LOGIC_1 is
    signal TEMP_A : std_logic; 
    signal TEMP_B : std_logic; 
begin
    
    TEMP_A <= not A when A_INV = '1' else A;
    TEMP_B <= not B when B_INV = '1' else B;

    A_AND_B <= TEMP_A and TEMP_B; 
    A_OR_B  <= TEMP_A or TEMP_B; 
    A_XOR_B <= TEMP_A xor TEMP_B; 
end RTL;


library ieee;
use ieee.std_logic_1164.all;

entity AL_BLOCK_4N is
    generic (
        SUB_MODULES : integer := 1 -- number of 4bit sub-modules 
    ); 
    port (
        A : in std_logic_vector(SUB_MODULES * 4 - 1 downto 0);
        B : in std_logic_vector(SUB_MODULES * 4 - 1 downto 0);
        CIN : in std_logic; 
        A_INV : in std_logic; 
        B_INV : in std_logic; 
        S : out std_logic_vector(SUB_MODULES * 4 - 1 downto 0);
        COUT : out std_logic; 
        A_AND_B : out std_logic_vector(SUB_MODULES * 4 - 1 downto 0);
        A_OR_B : out std_logic_vector(SUB_MODULES * 4 - 1 downto 0);
        A_XOR_B : out std_logic_vector(SUB_MODULES * 4 - 1 downto 0)
    ); 
end AL_BLOCK_4N;

architecture STRUCT of AL_BLOCK_4N is
    component LOGIC_1 is
        port (
            A       : in  std_logic; 
            B       : in  std_logic; 
            A_INV   : in  std_logic; 
            B_INV   : in  std_logic; 
            A_AND_B : out std_logic; -- becomes A nor B if A_INV = B_INV = 1
            A_OR_B  : out std_logic; -- becomes A nand B if A_INV = B_INV = 1
            A_XOR_B : out std_logic  -- becomes A xnor B if A_INV = B_INV = 1
        );
    end component;

    component CLA_4 is
        port (
            CIN  : in  std_logic; 
            P    : in  std_logic_vector(3 downto 0);
            G    : in  std_logic_vector(3 downto 0);  
            C    : out std_logic_vector(3 downto 0); 
            COUT : out std_logic  -- overflow carry
        );
    end component;

    signal TEMP_AND : std_logic_vector(SUB_MODULES * 4 - 1 downto 0);
    signal TEMP_OR : std_logic_vector(SUB_MODULES * 4 - 1 downto 0);
    signal TEMP_XOR : std_logic_vector(SUB_MODULES * 4 - 1 downto 0);
    signal TEMP_CASCADE_C : std_logic_vector(SUB_MODULES downto 0);
    signal TEMP_C : std_logic_vector(SUB_MODULES * 4 - 1 downto 0);
begin

    GEN_LOGIC_BLOCKS : for I in 0 to SUB_MODULES * 4 - 1 generate
        U : LOGIC_1 port map (
            A => A(I),
            B => B(I), 
            A_INV => A_INV,
            B_INV => B_INV, 
            A_AND_B => TEMP_AND(I), 
            A_OR_B => TEMP_OR(I), 
            A_XOR_B => TEMP_XOR(I)
        ); 
    end generate GEN_LOGIC_BLOCKS; 
    
    GEN_CLA_BLOCKS : for I in 0 to SUB_MODULES - 1 generate 
        U : CLA_4 port map (
            CIN => TEMP_CASCADE_C(I), 
            COUT => TEMP_CASCADE_C(I + 1), 
            C(3 downto 0) => TEMP_C(I * 4 + 3 downto I * 4),
            P(3 downto 0) => TEMP_OR(I * 4 + 3 downto I * 4), 
            G(3 downto 0) => TEMP_AND(I * 4 + 3 downto I * 4)
        ); 
    end generate GEN_CLA_BLOCKS; 

    A_AND_B <= TEMP_AND; 
    A_OR_B <= TEMP_OR; 
    A_XOR_B <= TEMP_XOR;
    
    TEMP_CASCADE_C(0) <= CIN;
    COUT <= TEMP_CASCADE_C(SUB_MODULES);  
    
    GEN_XORS : for I in S'range generate 
        S(I) <= TEMP_XOR(I) xor TEMP_C(I); 
    end generate GEN_XORS; 
end STRUCT;


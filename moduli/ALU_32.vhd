library ieee;
use ieee.std_logic_1164.all;

entity ALU_32 is
    port (
        A       : in  std_logic_vector(31 downto 0);
        B       : in  std_logic_vector(31 downto 0); 
        ALU_OP  : in  std_logic_vector(5 downto 0); 
        C       : out std_logic_vector(31 downto 0);
        ZERO    : out std_logic 
    ); 
end ALU_32;

architecture STRUCT of ALU_32 is
    component AL_BLOCK_4N is
        generic (
            SUB_MODULES : integer := 1 -- number of 4bit sub-modules 
        ); 
        port (
            A       : in std_logic_vector(SUB_MODULES * 4 - 1 downto 0);
            B       : in std_logic_vector(SUB_MODULES * 4 - 1 downto 0);
            CIN     : in std_logic; 
            A_INV   : in std_logic; 
            B_INV   : in std_logic; 
            S       : out std_logic_vector(SUB_MODULES * 4 - 1 downto 0);
            COUT    : out std_logic; 
            A_AND_B : out std_logic_vector(SUB_MODULES * 4 - 1 downto 0);
            A_OR_B  : out std_logic_vector(SUB_MODULES * 4 - 1 downto 0);
            A_XOR_B : out std_logic_vector(SUB_MODULES * 4 - 1 downto 0)
        ); 
    end component;

    constant ALL_ZEROS  : std_logic_vector(31 downto 0) := (others => '0');
    constant ONE        : std_logic_vector(31 downto 0) := (0      => '1', 
                                                            others => '0');

    signal TEMP_SUM  : std_logic_vector(31 downto 0);
    signal TEMP_AND  : std_logic_vector(31 downto 0);
    signal TEMP_OR   : std_logic_vector(31 downto 0);
    signal TEMP_XOR  : std_logic_vector(31 downto 0);
    signal TEMP_SLT  : std_logic_vector(31 downto 0); 
	signal TEMP_ZERO : std_logic; 
begin
    U0 : AL_BLOCK_4N 
        generic map ( SUB_MODULES => 8 )
        port map (
            A => A, 
            B => B, 
            CIN => ALU_OP(4), 
            A_INV => ALU_OP(5), 
            B_INV => ALU_OP(4), 
            S => TEMP_SUM, 
            COUT => open, 
            A_AND_B => TEMP_AND, 
            A_OR_B => TEMP_OR,
            A_XOR_B => TEMP_XOR 
        ); 

    with ALU_OP(2 downto 0) select 
        C <= B          when "000", 
             TEMP_AND   when "001", 
             TEMP_OR    when "010", 
             TEMP_XOR   when "011", 
             TEMP_SUM   when "100", 
             TEMP_SLT   when "101", 
             (others => '-') when others; 

    process (TEMP_SUM) is 
	 begin 
		if TEMP_SUM = ALL_ZEROS then 
			TEMP_ZERO <= '1'; 
		else
			TEMP_ZERO <= '0'; 
		end if; 
	 end process; 

	 ZERO <= TEMP_ZERO; 

    process (ALU_OP, A, B, TEMP_SUM) is 
    begin 
        if ((not TEMP_ZERO) and (
            (((not A(31)) and (not B(31))) and TEMP_SUM(31)) or 
            (((not ALU_OP(3)) and (not A(31))) and B(31)) or 
            ((A(31) and B(31)) and TEMP_SUM(31)) or
            ((ALU_OP(3) and A(31)) and (not B(31))))) = '1' then 
            TEMP_SLT <= ONE; 
        else 
            TEMP_SLT <= ALL_ZEROS; 
        end if; 
    end process; 

end STRUCT;


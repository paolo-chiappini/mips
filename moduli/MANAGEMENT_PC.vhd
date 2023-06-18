library ieee;
use ieee.std_logic_1164.all;

entity MANAGEMENT_PC is
	port(
		ADDR       : in std_logic_vector(25 downto 0);
		PC         : in std_logic_vector(31 downto 0);
		IMM  	     : in std_logic_vector(31 downto 0);
		JUMP       : in std_logic;
		JUMP_REG   : in std_logic;
		BRANCH_BEQ : in std_logic;
		BRANCH_BNE : in std_logic;
		ZERO       : in std_logic;
		D0         : in std_logic_vector(31 downto 0);
		NEW_PC     : out std_logic_vector(31 downto 0);
		PC_PLUS_4  : out std_logic_vector(31 downto 0)
	);
end MANAGEMENT_PC;

architecture RTL of MANAGEMENT_PC is

	component AL_BLOCK_4N is
    generic (
        SUB_MODULES : integer := 1 -- number of 4bit sub-modules 
    ); 
    port (
        A 			: in std_logic_vector(SUB_MODULES * 4 - 1 downto 0);
        B 			: in std_logic_vector(SUB_MODULES * 4 - 1 downto 0);
        CIN 		: in std_logic; 
        A_INV 		: in std_logic; 
        B_INV 		: in std_logic; 
        S 			: out std_logic_vector(SUB_MODULES * 4 - 1 downto 0);
        COUT 		: out std_logic; 
        A_AND_B 	: out std_logic_vector(SUB_MODULES * 4 - 1 downto 0);
        A_OR_B 	: out std_logic_vector(SUB_MODULES * 4 - 1 downto 0);
        A_XOR_B 	: out std_logic_vector(SUB_MODULES * 4 - 1 downto 0)
    ); 
	end component;
	
	signal ADDR_SHIFT : std_logic_vector(27 downto 0);
	signal IMM_SHIFT 	: std_logic_vector(31 downto 0);
	signal PC_4 		: std_logic_vector(31 downto 0);
	signal BRANCH     : std_logic;
	signal BE 			: std_logic_vector(31 downto 0);
	signal BF_JUMP 	: std_logic_vector(31 downto 0);
	signal AF_JUMP 	: std_logic_vector(31 downto 0);
	signal NEW_ADDR 	: std_logic_vector(31 downto 0);
begin

	ADDR_SHIFT <= ADDR & "00";
	IMM_SHIFT  <= IMM(29 downto 0) & "00";
	BRANCH     <= (BRANCH_BEQ and ZERO) or (BRANCH_BNE and not ZERO);
   
	U0 : AL_BLOCK_4N
		generic map(
			SUB_MODULES => 8 
		)
		port map (
        A 	   => PC,
        B 		=> x"00000004",
        CIN 	=> '0',
        A_INV 	=> '0',
        B_INV 	=> '0',
        S 		=> PC_4, 
		A_AND_B => open, 
		A_OR_B  => open, 
		A_XOR_B => open 
      ); 
	 
	
	U1 : AL_BLOCK_4N
		generic map(
			SUB_MODULES => 8 
		)
		port map (
        A 	   => PC_4,
        B 		=> IMM_SHIFT,
        CIN 	=> '0',
        A_INV 	=> '0',
        B_INV 	=> '0',
        S 		=> BE, 
		A_AND_B => open, 
		A_OR_B  => open, 
		A_XOR_B => open 
      ); 
	
	
	NEW_ADDR <= PC_4(31 downto 28) & ADDR_SHIFT;
	
	BF_JUMP <= PC_4 when BRANCH = '0' else
			     BE;
				  
	AF_JUMP <= NEW_ADDR when JUMP = '1' else
			     BF_JUMP;
				  
	NEW_PC  <= AF_JUMP when JUMP_REG = '0' else
			     D0;
	PC_PLUS_4 <= PC_4; 
	
end RTL;


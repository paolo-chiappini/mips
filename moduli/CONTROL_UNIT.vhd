library ieee;
use ieee.std_logic_1164.all;

entity CONTROL_UNIT is
	port(
		OPCODE 	  : in std_logic_vector(5 downto 0);
		FUNCT 	  : in std_logic_vector(5 downto 0);
		LUI		  : out std_logic; 
		DST_REG    : out std_logic;
		WR_REG     : out std_logic;
		ALU_SRC    : out std_logic;
		SIGN_EXT   : out std_logic; 
		ALU_OP     : out std_logic_vector(5 downto 0);
		BRANCH_BEQ : out std_logic;
		BRANCH_BNE : out std_logic;
		JUMP       : out std_logic;
		JAL        : out std_logic;
		JUMP_REG   : out std_logic;
		SHIFT_OP   : out std_logic_vector(1 downto 0);
		MEM_OP	  : out std_logic; 
		MEM_TO_REG : out std_logic;
		DATA_ENA   : out std_logic;
		FETCH_I    : out std_logic
	);
end CONTROL_UNIT;

architecture RTL of CONTROL_UNIT is
	signal SIGNAL_CONTROL : std_logic_vector(21 downto 0);
begin

	SIGNAL_CONTROL <= "0110000-1000000000-001" when OPCODE = "000000" and FUNCT = "100000" else -- add
							  "0110001-1000000000-001" when OPCODE = "000000" and FUNCT = "100010" else -- sub
							  "0011000-1000000000-001" when OPCODE = "001000" else -- addi
							  "0110000-0010000000-001" when OPCODE = "000000" and FUNCT = "100100" else -- and
							  "0110000-0110000000-001" when OPCODE = "000000" and FUNCT = "100101" else -- or
							  "0110011-0010000000-001" when OPCODE = "000000" and FUNCT = "100111" else -- nor
							  "0110000-0110000000-001" when OPCODE = "000000" and FUNCT = "100110" else -- xor
							  "0011100-0010000000-001" when OPCODE = "001100" else -- andi
							  "0011100-0100000000-001" when OPCODE = "001101" else -- ori
							  "0011100-0110000000-001" when OPCODE = "001110" else -- xori
							  "01100---0000000001-001" when OPCODE = "000000" and FUNCT = "000000" else -- sll
							  "01100---0000000010-001" when OPCODE = "000000" and FUNCT = "000010" else -- srl
							  "01100---0000000011-001" when OPCODE = "000000" and FUNCT = "000011" else -- sra
							  "011000111010000000-001" when OPCODE = "000000" and FUNCT = "101010" else -- slt
							  "011000101010000000-001" when OPCODE = "000000" and FUNCT = "101011" else -- sltu
							  "001100111010000000-001" when OPCODE = "001010" else -- slti
							  "001110101010000000-001" when OPCODE = "001011" else -- sltiu
							  "0-0-0------001-0---001" when OPCODE = "000010" else -- j
							  "0-1-0------0011000-001" when OPCODE = "000011" else -- jal
							  "0-0-0----------100-001" when OPCODE = "000000" and FUNCT = "001000" else -- jr
							  "0-00001-100100-000-001" when OPCODE = "000100" else -- beq
							  "0-00001-100010-000-001" when OPCODE = "000101" else -- bne
							  "10110---0000000000-001" when OPCODE = "001111" else -- lui
							  "0011000-10000000000111" when OPCODE = "100011" else -- lw
							  "0-01000-10000000001011" when OPCODE = "101011" else -- sw
							  "--0--------000-0----01"; -- default

	LUI 	   <= SIGNAL_CONTROL(21);  
	DST_REG    <= SIGNAL_CONTROL(20);
	WR_REG     <= SIGNAL_CONTROL(19);
	ALU_SRC    <= SIGNAL_CONTROL(18);
	SIGN_EXT   <= SIGNAL_CONTROL(17); 
	ALU_OP     <= SIGNAL_CONTROL(16 downto 11);
	BRANCH_BEQ <= SIGNAL_CONTROL(10);
	BRANCH_BNE <= SIGNAL_CONTROL(9);
	JUMP       <= SIGNAL_CONTROL(8);
	JAL        <= SIGNAL_CONTROL(7);
	JUMP_REG   <= SIGNAL_CONTROL(6);
	SHIFT_OP   <= SIGNAL_CONTROL(5 downto 4);
	MEM_OP 	   <= SIGNAL_CONTROL(3);
	MEM_TO_REG <= SIGNAL_CONTROL(2);
	DATA_ENA   <= SIGNAL_CONTROL(1);
	FETCH_I    <= SIGNAL_CONTROL(0);
end RTL;

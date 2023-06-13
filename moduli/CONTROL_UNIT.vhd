library ieee;
use ieee.std_logic_1164.all;

entity CONTROL_UNIT is
	port(
		OPCODE 	  : in std_logic_vector(5 downto 0);
		FUNCT 	  : in std_logic_vector(5 downto 0);
		DST_REG    : out std_logic;
		WR_REG     : out std_logic;
		ALU_SRC   : out std_logic;
		ALU_OP     : out std_logic_vector(5 downto 0);
		BRANCH_BEQ : out std_logic;
		BRANCH_BNE : out std_logic;
		JUMP       : out std_logic;
		JAL        : out std_logic;
		JUMP_REG   : out std_logic;
		SHIFT_OP   : out std_logic_vector(1 downto 0);
		MEM_WR     : out std_logic;
		MEM_RD     : out std_logic;
		MEM_TO_REG : out std_logic;
		DATA_ENA   : out std_logic;
		FETCH_I    : out std_logic
	);
end CONTROL_UNIT;

architecture RTL of CONTROL_UNIT is
	signal SIGNAL_CONTROL : std_logic_vector(20 downto 0);
begin

	SIGNAL_CONTROL <= "11000-100000000000001" when OPCODE = "000000" and FUNCT = "100000" else -- add
							"11001-100000000000001" when OPCODE = "000000" and FUNCT = "100010" else -- sub
							"01100-100000000000001" when OPCODE = "001000" and FUNCT = "------" else -- addiu
							"11000-001000000000001" when OPCODE = "000000" and FUNCT = "100100" else -- and
							"11000-011000000000001" when OPCODE = "000000" and FUNCT = "100101" else -- or
							"11011-001000000000001" when OPCODE = "000000" and FUNCT = "100111" else -- nor
							"11000-011000000000001" when OPCODE = "000000" and FUNCT = "100110" else -- xor
							"01100-001000000000001" when OPCODE = "001100" and FUNCT = "------" else -- andi
							"01100-010000000000001" when OPCODE = "001101" and FUNCT = "------" else -- ori
							"01100-011000000000001" when OPCODE = "001110" and FUNCT = "------" else -- xori
							"110---000000000100001" when OPCODE = "000000" and FUNCT = "000000" else -- sll
							"110---000000001000001" when OPCODE = "000000" and FUNCT = "000010" else -- srl
							"110---000000001100001" when OPCODE = "000000" and FUNCT = "000011" else -- sra
							"110011101000000000001" when OPCODE = "000000" and FUNCT = "101010" else -- slt
							"110010101000000000001" when OPCODE = "000000" and FUNCT = "101011" else -- sltu
							"010011101000000000001" when OPCODE = "001010" and FUNCT = "------" else -- slti
							"010010101000000000001" when OPCODE = "001011" and FUNCT = "------" else -- sltiu
							"-0-------001-0--00001" when OPCODE = "000010" and FUNCT = "------" else -- j
							"-1-------001100000001" when OPCODE = "000011" and FUNCT = "------" else -- jal
							"-0-----------10000001" when OPCODE = "000000" and FUNCT = "001000" else -- jr
							"-0001-100100-00000001" when OPCODE = "000100" and FUNCT = "------" else -- beq
							"-0001-100010-00000001" when OPCODE = "000101" and FUNCT = "------" else -- bne
							"011---000000000000001" when OPCODE = "001111" and FUNCT = "------" else -- lui
							"01100-100000000001111" when OPCODE = "100011" and FUNCT = "------" else -- lw
							"-0100-100000000010011" when OPCODE = "101011" and FUNCT = "------" else -- sw
							"---------------------"; -- default

	DST_REG    <= SIGNAL_CONTROL(20);
	WR_REG     <= SIGNAL_CONTROL(19);
	ALU_SRC   <= SIGNAL_CONTROL(18);
	ALU_OP     <= SIGNAL_CONTROL(17 downto 12);
	BRANCH_BEQ <= SIGNAL_CONTROL(11);
	BRANCH_BNE <= SIGNAL_CONTROL(10);
	JUMP       <= SIGNAL_CONTROL(9);
	JAL        <= SIGNAL_CONTROL(8);
	JUMP_REG   <= SIGNAL_CONTROL(7);
	SHIFT_OP   <= SIGNAL_CONTROL(6 downto 5);
	MEM_WR     <= SIGNAL_CONTROL(4);
	MEM_RD     <= SIGNAL_CONTROL(3);
	MEM_TO_REG <= SIGNAL_CONTROL(2);
	DATA_ENA   <= SIGNAL_CONTROL(1);
	FETCH_I    <= SIGNAL_CONTROL(0);
end RTL;
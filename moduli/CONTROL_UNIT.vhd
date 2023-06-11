library ieee;
use ieee.std_logic_1164.all;

entity CONTROL_UNIT is
	port(
		OPCODE 	: in std_logic_vector(5 downto 0);
		FUNCT 	: in std_logic_vector(5 downto 0);
		DstReg   : out std_logic;
		WrReg   	: out std_logic;
		AluSrc   : out std_logic;
		AluOp    : out std_logic_vector(5 downto 0);
		Branch   : out std_logic;
		Jump     : out std_logic;
		Jal      : out std_logic;
		JumpReg  : out std_logic;
		ShiftOp  : out std_logic_vector(1 downto 0);
		MemWr    : out std_logic;
		MemRd    : out std_logic;
		MemToReg : out std_logic;
		DataEna  : out std_logic;
		FetchL   : out std_logic
	);
end CONTROL_UNIT;

architecture RTL of CONTROL_UNIT is
	signal SIGNAL_CONTROL : std_logic_vector(19 downto 0);
begin

	SIGNAL_CONTROL <= "11000-10000000000001" when OPCODE = "000000" and FUNCT = "100000" else -- add
							"11001-10000000000001" when OPCODE = "000000" and FUNCT = "100010" else -- sub
							"01100-10000000000001" when OPCODE = "001000" and FUNCT = "------" else -- addiu
							"11000-00100000000001" when OPCODE = "000000" and FUNCT = "100100" else -- and
							"11000-01100000000001" when OPCODE = "000000" and FUNCT = "100101" else -- or
							"11011-00100000000001" when OPCODE = "000000" and FUNCT = "100111" else -- nor
							"11000-01100000000001" when OPCODE = "000000" and FUNCT = "100110" else -- xor
							"01100-00100000000001" when OPCODE = "001100" and FUNCT = "------" else -- andi
							"01100-01000000000001" when OPCODE = "001101" and FUNCT = "------" else -- ori
							"01100-01100000000001" when OPCODE = "001110" and FUNCT = "------" else -- xori
							"110---00000000100001" when OPCODE = "000000" and FUNCT = "000000" else -- sll
							"110---00000001000001" when OPCODE = "000000" and FUNCT = "000010" else -- srl
							"110---00000001100001" when OPCODE = "000000" and FUNCT = "000011" else -- sra
							"11001110100000000001" when OPCODE = "000000" and FUNCT = "101010" else -- slt
							"11001010100000000001" when OPCODE = "000000" and FUNCT = "101011" else -- sltu
							"01001110100000000001" when OPCODE = "001010" and FUNCT = "------" else -- slti
							"01001010100000000001" when OPCODE = "001011" and FUNCT = "------" else -- sltiu
							"-0-------01-0--00001" when OPCODE = "000010" and FUNCT = "------" else -- j
							"-1-------01100000001" when OPCODE = "000011" and FUNCT = "------" else -- jal
							"-0----------10000001" when OPCODE = "000000" and FUNCT = "001000" else -- jr
							"-0001-10010-00000001" when OPCODE = "000100" and FUNCT = "------" else -- beq
							"-0001-10010-00000001" when OPCODE = "000101" and FUNCT = "------" else -- bne
							"011---00000000000001" when OPCODE = "001111" and FUNCT = "------" else -- lui
							"01100-10000000001111" when OPCODE = "100011" and FUNCT = "------" else -- lw
							"-0100-10000000010011" when OPCODE = "101011" and FUNCT = "------" else -- sw
							"--------------------"; -- default
	
	DstReg   <= SIGNAL_CONTROL(19);
	WrReg   	<= SIGNAL_CONTROL(18);
	AluSrc   <= SIGNAL_CONTROL(17);
	AluOp    <= SIGNAL_CONTROL(16 downto 11);
	Branch   <= SIGNAL_CONTROL(10);
	Jump     <= SIGNAL_CONTROL(9);
	Jal      <= SIGNAL_CONTROL(8);
	JumpReg  <= SIGNAL_CONTROL(7);
	ShiftOp  <= SIGNAL_CONTROL(6 downto 5);
	MemWr    <= SIGNAL_CONTROL(4);
	MemRd    <= SIGNAL_CONTROL(3);
	MemToReg <= SIGNAL_CONTROL(2);
	DataEna  <= SIGNAL_CONTROL(1);
	FetchL   <= SIGNAL_CONTROL(0);
end RTL;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 ENTITY TB_CONTROL_UNIT IS
END TB_CONTROL_UNIT;
 
ARCHITECTURE behavior OF TB_CONTROL_UNIT IS 

 
    COMPONENT CONTROL_UNIT
    PORT(
         OPCODE : IN  std_logic_vector(5 downto 0);
         FUNCT : IN  std_logic_vector(5 downto 0);
         DstReg : OUT  std_logic;
         WrReg : OUT  std_logic;
         AluSrc : OUT  std_logic;
         AluOp : OUT  std_logic_vector(5 downto 0);
         Branch : OUT  std_logic;
         Jump : OUT  std_logic;
         Jal : OUT  std_logic;
         JumpReg : OUT  std_logic;
         ShiftOp : OUT  std_logic_vector(1 downto 0);
         MemWr : OUT  std_logic;
         MemRd : OUT  std_logic;
         MemToReg : OUT  std_logic;
         DataEna : OUT  std_logic;
         FetchL : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal OPCODE : std_logic_vector(5 downto 0) := (others => '0');
   signal FUNCT : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal DstReg : std_logic;
   signal WrReg : std_logic;
   signal AluSrc : std_logic;
   signal AluOp : std_logic_vector(5 downto 0);
   signal Branch : std_logic;
   signal Jump : std_logic;
   signal Jal : std_logic;
   signal JumpReg : std_logic;
   signal ShiftOp : std_logic_vector(1 downto 0);
   signal MemWr : std_logic;
   signal MemRd : std_logic;
   signal MemToReg : std_logic;
   signal DataEna : std_logic;
   signal FetchL : std_logic;
 
BEGIN
 
   uut: CONTROL_UNIT PORT MAP (
          OPCODE => OPCODE,
          FUNCT => FUNCT,
          DstReg => DstReg,
          WrReg => WrReg,
          AluSrc => AluSrc,
          AluOp => AluOp,
          Branch => Branch,
          Jump => Jump,
          Jal => Jal,
          JumpReg => JumpReg,
          ShiftOp => ShiftOp,
          MemWr => MemWr,
          MemRd => MemRd,
          MemToReg => MemToReg,
          DataEna => DataEna,
          FetchL => FetchL
        );
 

   -- Stimulus process
   stim_proc: process
   begin	
		-- setup
		OPCODE <= (others => '0');
      FUNCT  <= (others => '0');
      wait for 20 ns;
		
		-- add
		OPCODE <= (others => '0');
      FUNCT  <= "100000";
      wait for 20 ns;	
		
		-- sub
		OPCODE <= (others => '0');
      FUNCT  <= "100010";
      wait for 20 ns;

		-- addiu
		OPCODE <= "001000";
      FUNCT  <= "000000";
      wait for 20 ns;
		
		-- and
		OPCODE <= (others => '0');
      FUNCT  <= "100100";
      wait for 20 ns;
		
		-- or
		OPCODE <= (others => '0');
      FUNCT  <= "100101";
      wait for 20 ns;
		
		-- nor
		OPCODE <= (others => '0');
      FUNCT  <= "100111";
      wait for 20 ns;
		
		-- xor
		OPCODE <= (others => '0');
      FUNCT  <= "100110";
      wait for 20 ns;
		
		-- andi
		OPCODE <= "001100";
      FUNCT  <= "100110";
      wait for 20 ns;
		
		-- ori
		OPCODE <= "001101";
      FUNCT  <= "000000";
      wait for 20 ns;
		
		-- xori
		OPCODE <= "001110";
      FUNCT  <= "100110";
      wait for 20 ns;
		
		-- sll
		OPCODE <= "000000";
      FUNCT  <= "000000";
      wait for 20 ns;
		
		-- srl
		OPCODE <= "000000";
      FUNCT  <= "000010";
      wait for 20 ns;
		
		-- sra
		OPCODE <= "000000";
      FUNCT  <= "000011";
      wait for 20 ns;
		
		-- slt
		OPCODE <= "000000";
      FUNCT  <= "101010";
      wait for 20 ns;
		
		-- sltu
		OPCODE <= "000000";
      FUNCT  <= "101011";
      wait for 20 ns;
		
		-- slti
		OPCODE <= "001010";
      FUNCT  <= "111111";
      wait for 20 ns;
		
		-- sltiu
		OPCODE <= "001011";
      FUNCT  <= "101010";
      wait for 20 ns;
		
		-- j
		OPCODE <= "000010";
      FUNCT  <= "000011";
      wait for 20 ns;
		
		-- jal
		OPCODE <= "000011";
      FUNCT  <= "000011";
      wait for 20 ns;
		
		-- jr
		OPCODE <= "000000";
      FUNCT  <= "001000";
      wait for 20 ns;
		
		-- beq
		OPCODE <= "000100";
      FUNCT  <= "001000";
      wait for 20 ns;
		
		-- bne
		OPCODE <= "000101";
      FUNCT  <= "001000";
      wait for 20 ns;
		
		-- lui
		OPCODE <= "001111";
      FUNCT  <= "001000";
      wait for 20 ns;
		
		-- lw
		OPCODE <= "100011";
      FUNCT  <= "001000";
      wait for 20 ns;
		
		-- sw
		OPCODE <= "101011";
      FUNCT  <= "000000";
      wait;
   end process;
END;


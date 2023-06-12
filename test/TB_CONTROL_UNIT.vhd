ARCHITECTURE behavior OF TB_CONTROL_UNIT IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONTROL_UNIT
    port(
		OPCODE 	  : in std_logic_vector(5 downto 0);
		FUNCT 	  : in std_logic_vector(5 downto 0);
		DST_REG    : out std_logic;
		WR_REG     : out std_logic;
		ALUS_SRC   : out std_logic;
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
    END COMPONENT;

   --Inputs
   signal OPCODE : std_logic_vector(5 downto 0);
   signal FUNCT : std_logic_vector(5 downto 0);

 	--Outputs
   signal DST_REG    :  std_logic;
	signal WR_REG     :  std_logic;
	signal ALUS_SRC   :  std_logic;
	signal ALU_OP     :  std_logic_vector(5 downto 0);
	signal BRANCH_BEQ :  std_logic;
	signal BRANCH_BNE :  std_logic;
	signal JUMP       :  std_logic;
	signal JAL        :  std_logic;
	signal JUMP_REG   :  std_logic;
	signal SHIFT_OP   :  std_logic_vector(1 downto 0);
	signal MEM_WR     :  std_logic;
	signal MEM_RD     :  std_logic;
	signal MEM_TO_REG :  std_logic;
	signal DATA_ENA   :  std_logic;
	signal FETCH_I    :  std_logic;
 
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: CONTROL_UNIT PORT MAP (
          OPCODE => OPCODE,
          FUNCT => FUNCT,
          DST_REG => DST_REG,
          WR_REG => WR_REG,
          ALUS_SRC => ALUS_SRC,
          ALU_OP => ALU_OP,
			 BRANCH_BEQ => BRANCH_BEQ,
          BRANCH_BNE => BRANCH_BNE,
          JUMP => JUMP,
          JAL => JAL,
          JUMP_REG => JUMP_REG,
          SHIFT_OP => SHIFT_OP,
          MEM_WR => MEM_WR,
          MEM_RD => MEM_RD,
          MEM_TO_REG => MEM_TO_REG,
          DATA_ENA => DATA_ENA,
          FETCH_I => FETCH_I
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


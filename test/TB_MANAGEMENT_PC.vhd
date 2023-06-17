ARCHITECTURE behavior OF TB_MANAGEMENT_PC IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MANAGEMENT_PC
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
         PC_PLUS_4  : out std_logic_vector(31 downto 0);
		);
    END COMPONENT;
    

   --Inputs
   signal ADDR : std_logic_vector(25 downto 0);
   signal PC : std_logic_vector(31 downto 0);
   signal IMM : std_logic_vector(31 downto 0);
   signal JUMP : std_logic;
   signal JUMP_REG : std_logic;
   signal BRANCH_BEQ : std_logic;
	signal BRANCH_BNE : std_logic;
   signal ZERO : std_logic;
   signal D0 : std_logic_vector(31 downto 0);

 	--Outputs
   signal NEW_PC : std_logic_vector(31 downto 0);
   signal PC_PLUS_4 : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MANAGEMENT_PC PORT MAP (
          ADDR => ADDR,
          PC => PC,
          IMM => IMM,
          JUMP => JUMP,
          JUMP_REG => JUMP_REG,
          BRANCH_BEQ => BRANCH_BEQ,
			 BRANCH_BNE => BRANCH_BNE,
          ZERO => ZERO,
          D0 => D0,
          NEW_PC => NEW_PC,
          PC_PLUS_4 => PC_PLUS_4
        );

 

   -- Stimulus process
   stim_proc: process
   begin	
         -- only PC + 4 	
			ADDR        <= (others => '0');
         PC 	      <= (others => '0');
         IMM         <= (others => '0');
         JUMP        <= '0';
         JUMP_REG    <= '0';
         BRANCH_BEQ  <= '0';
			BRANCH_BNE  <= '0';
         ZERO        <= '0';
         D0          <= (others => '0');
      wait for 100 ns;	
		
		-- jump = 1	
			ADDR      <= "10001000000000000000100101";
         PC 	    <= "11111000000000000000100101000000";
         JUMP      <= '1';
		-- new_pc =  11111+0001000000000000000100101+00
		
      wait for 100 ns;	
		
		-- JUMP_REG = 1
         PC 	    <= "11111000000000000000100101000000";
			JUMP 		 <= '0';
         JUMP_REG  <= '1';
			D0        <= "11000000000111000000100101001101";
		-- new_pc =  11000000000111000000100101001101 equal to D0
		wait for 100 ns;
		-- JUMP_REG = 1 caso particolare
         PC 	    <= "11111000000000000000100101000000";
			JUMP 		 <= '1';
			JUMP_REG  <= '1';
		-- new_pc =  11000000000111000000100101001101 equal to D0
      wait for 100 ns;	

		-- PC + 4
         PC 	    <= "11111000000000000000100101000100";
			JUMP      <= '0';
         JUMP_REG  <= '0';
         BRANCH_BEQ  <= '0';
			BRANCH_BNE  <= '0';
         ZERO      <= '0';
		-- new_pc =  11111000000000000000100101001000
      wait for 100 ns;	
		
		-- beq true
         PC 	     <= "11111000000000000000100101000100";
         BRANCH_BEQ <= '1';
			BRANCH_BNE <= '0';
         ZERO       <= '1';
			IMM		  <= "00000000000000000000100101010100";
			---          00000000000000000010010101010000
			---          11111000000000000000100101001000
			-- new_pc =  11111000000000000010111010011000
      wait for 100 ns;
		
		-- beq false
         PC 	     <= "11111000000000000000100101000100";
         BRANCH_BEQ <= '1';
			BRANCH_BNE <= '0';
         ZERO       <= '0';
			--- new_pc = 11111000000000000000100101001000
      wait for 100 ns;
		
		-- bne true
         BRANCH_BEQ <= '0';
			BRANCH_BNE <= '1';
         ZERO       <= '0';
			---          00000000000000000010010101010000
			---          11111000000000000000100101001000
			--  new_pc = 11111000000000000010111010011000
      wait for 100 ns;
		
		-- bne false
         BRANCH_BEQ <= '0';
		 BRANCH_BNE <= '1';
         ZERO       <= '1';
			--- new_pc = 11111000000000000000100101001000
      wait;
		
   end process;
END;

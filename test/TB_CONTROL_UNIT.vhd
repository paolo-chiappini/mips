LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 ENTITY TB_CONTROL_UNIT IS
END TB_CONTROL_UNIT;
 
ARCHITECTURE behavior OF TB_CONTROL_UNIT IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
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
 
	-- Instantiate the Unit Under Test (UUT)
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
		-- sll
		OPCODE <= (others => '0');
      FUNCT  <= (others => '0');
      wait for 20 ns;
		
		-- add
		OPCODE <= (others => '0');
      FUNCT  <= "100000";
      wait for 20 ns;	
      -- insert stimulus here 
		-- fare tutti i test delle operazioni
      wait;
   end process;
END;


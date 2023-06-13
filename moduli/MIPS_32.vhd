library ieee;
use ieee.std_logic_1164.all;

entity MIPS_32 is
    port (
        CLK   : in  std_logic; 
        RST   : in  std_logic; 
        
        IADDR : out std_logic_vector(31 downto 0);
        IDATA : in  std_logic_vector(31 downto 0); 
        IEN   : out std_logic; 

        DADDR : out std_logic_vector(31 downto 0);
        DOUT  : out std_logic_vector(31 downto 0); 
        DIN   : in  std_logic_vector(31 downto 0);
        DOP   : out std_logic; 
        DEN   : out std_logic
    ); 
end MIPS_32;

architecture STRUCT of MIPS_32 is
    component CONTROL_UNIT is
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
    end component;

    component MANAGEMENT_PC is
        port(
            ADDR       : in std_logic_vector(25 downto 0);
            PC         : in std_logic_vector(31 downto 0);
            IMM  	   : in std_logic_vector(31 downto 0);
            JUMP       : in std_logic;
            JUMP_REG   : in std_logic;
            BRANCH_BEQ : in std_logic;
            BRANCH_BNE : in std_logic;
            ZERO       : in std_logic;
            D0         : in std_logic_vector(31 downto 0);
            NEW_PC     : out std_logic_vector(31 downto 0)
        );
    end component;

    component REG_UNIT is
        port(
            CLK: in std_logic;
            RST: in std_logic;
              
            WR_REG: in std_logic;
            JAL: in std_logic;
            DST_REG: in std_logic;
    
            PC_IN: in std_logic_vector(0 to 31); -- Data from Program Counter
            WB_IN: in std_logic_vector(0 to 31); -- Data from Writeback
              
            RS: in std_logic_vector(0 to 4);
            RT: in std_logic_vector(0 to 4);
            RD: in std_logic_vector(0 to 4);
    
            D0: out std_logic_vector(0 to 31);
            D1: out std_logic_vector(0 to 31)
        );
    end component;

    component ALU_32 is
        port (
            A       : in  std_logic_vector(31 downto 0);
            B       : in  std_logic_vector(31 downto 0); 
            ALU_OP  : in  std_logic_vector(5 downto 0); 
            C       : out std_logic_vector(31 downto 0);
            ZERO    : out std_logic 
        ); 
    end component;

    component LOG_SHIFTER_32 is
        port (
            X        : in  std_logic_vector(31 downto 0); 
            SHAMT    : in  std_logic_vector(4 downto 0); 
            SHIFT_OP : in  std_logic_vector(1 downto 0);
            Y        : out std_logic_vector(31 downto 0)
        ); 
    end component;

    component SHIFTER_N_M is
        generic ( 
            N : integer := 32; -- number of bits 
            M : integer := 1   -- fixed shift amount 
        ); 
        port (
            X       : in  std_logic_vector(N - 1 downto 0);
            ENABLE  : in  std_logic; 
            FILL    : in  std_logic; -- bit used to fill the shifted spaces  
            Y       : out std_logic_vector(N - 1 downto 0)
        );
    end component;

    component REG_N IS
	    generic(
		    N: integer := 32
        );
        port(
            CLK: in std_logic;
            RST: in std_logic;
            PRESET: std_logic_vector(0 to N-1) := (others => '0');
            EN: in std_logic;

            DIN: in std_logic_vector(0 to N-1);
            DOUT: out std_logic_vector(0 to N-1)
        );
    end component;

    signal SIG_CLK : std_logic; 
    signal SIG_RST : std_logic; 

    signal SIG_PC_IN : std_logic_vector(31 downto 0); 
    signal SIG_PC_OUT : std_logic_vector(31 downto 0);

    signal SIG_INSTR : std_logic_vector(31 downto 0); 
    signal SIG_ADDR : std_logic_vector(31 downto 0); 
    signal SIG_WRITE_BACK : std_logic_vector(31 downto 0);

    signal SIG_D0 : std_logic_vector(31 downto 0);
    signal SIG_D1 : std_logic_vector(31 downto 0);

    signal SIG_ZERO : std_logic; 
    signal SIG_ALU_B : std_logic_vector(31 downto 0);
    signal SIG_ALU_OUT : std_logic_vector(31 downto 0); 
    signal SIG_SHIFT_OUT : std_logic_vector(31 downto 0);

    signal SIG_SIGN_EXT : std_logic_vector(31 downto 0);

    -- CU control signals
    signal SIG_DST_REG : std_logic; 
    signal SIG_WR_REG : std_logic; 
    signal SIG_ALU_SRC : std_logic; 
    signal SIG_ALU_OP : std_logic_vector(5 downto 0); 
    signal SIG_BEQ : std_logic; 
    signal SIG_BNE : std_logic; 
    signal SIG_JUMP : std_logic; 
    signal SIG_JAL : std_logic; 
    signal SIG_JR : std_logic; 
    signal SIG_SHIFT_OP : std_logic_vector(1 downto 0);
    signal SIG_MEM_WR : std_logic; 
    signal SIG_MEM_RD : std_logic; 
    signal SIG_MEM_TO_REG : std_logic; 
    signal SIG_DATA_ENA : std_logic; 
    signal SIG_FETCH_I : std_logic; 
begin

    SIG_CLK <= CLK; 
    SIG_RST <= RST; 

    -- PC 
    U0 : REG_N 
        generic map ( N => 32 )
        port map (
            CLK => SIG_CLK, 
            RST => SIG_RST, 
            PRESET => x"00000080", 
            EN => '1', 
            DIN => SIG_PC_IN, 
            DOUT => SIG_PC_OUT
        ); 

    -- CU 
    U1 : CONTROL_UNIT 
        port map (
            OPCODE => SIG_INSTR(5 downto 0), 
            FUNCT => SIG_INSTR(31 downto 26), 
            DST_REG => SIG_DST_REG, 
            WR_REG => SIG_WR_REG, 
            ALU_SRC => SIG_ALU_SRC, 
            ALU_OP => SIG_ALU_OP, 
            BRANCH_BEQ => SIG_BEQ, 
            BRANCH_BNE => SIG_BNE, 
            JUMP => SIG_JUMP, 
            JAL => SIG_JAL, 
            JUMP_REG => SIG_JR, 
            SHIFT_OP => SIG_SHIFT_OP, 
            MEM_WR => SIG_MEM_WR, 
            MEM_RD => SIG_MEM_RD, 
            MEM_TO_REG => SIG_MEM_TO_REG, 
            DATA_ENA => SIG_DATA_ENA, 
            FETCH_I => SIG_FETCH_I
        ); 

    -- Register File 
    U2: REG_UNIT
        port map (
            CLK => SIG_CLK, 
            RST => SIG_RST, 
            WR_REG => SIG_WR_REG, 
            JAL => SIG_JAL, 
            DST_REG => SIG_DST_REG, 
            PC_IN => SIG_PC_OUT, 
            WB_IN => SIG_WRITE_BACK, 
            RS => SIG_INSTR(25 downto 21), 
            RT => SIG_INSTR(20 downto 16), 
            RD => SIG_INSTR(15 downto 11),
            D0 => SIG_D0, 
            D1 => SIG_D1
        ); 

    -- Sign extend
    U3 : SHIFTER_N_M 
        generic map (
            N => 32, 
            M => 16
        )
        port map (
            X(31 downto 16) => SIG_INSTR(15 downto 0), 
            ENABLE => '1', 
            FILL => SIG_INSTR(15), 
            Y => SIG_SIGN_EXT
        ); 

    -- ALU src
    SIG_ALU_B <= SIG_SIGN_EXT when SIG_ALU_SRC = '1' else SIG_D1; 

    -- ALU 
    U4 : ALU_32 
        port map (
            A => SIG_D0, 
            B => SIG_ALU_B, 
            ALU_OP => SIG_ALU_OP, 
            C => SIG_ALU_OUT, 
            ZERO => SIG_ZERO
        ); 

    -- Shifter 
    U5 : LOG_SHIFTER_32 
        port map (
            X => SIG_ALU_OUT, 
            SHAMT => SIG_INSTR(10 downto 6), 
            SHIFT_OP => SIG_SHIFT_OP, 
            Y => SIG_SHIFT_OUT
        ); 

    -- Write back 
    SIG_WRITE_BACK <= DIN when SIG_MEM_TO_REG = '1' else SIG_SHIFT_OUT;

    -- Branch unit 
    U6 : MANAGEMENT_PC
        port map (
            ADDR => SIG_INSTR(25 downto 0), 
            PC => SIG_PC_OUT, 
            IMM => SIG_SIGN_EXT, 
            JUMP => SIG_JUMP, 
            JUMP_REG => SIG_JR, 
            BRANCH_BEQ => SIG_BEQ, 
            BRANCH_BNE => SIG_BNE, 
            ZERO => SIG_ZERO,
            D0 => SIG_D0,
            NEW_PC => SIG_PC_IN
        ); 

    -- Mem interface signals 
    IADDR <= SIG_PC_OUT; 
    IEN <= SIG_FETCH_I; 
    SIG_INSTR <= IDATA; 
    DADDR <= SIG_SHIFT_OUT; 
    DOUT <= SIG_D1; 
    DOP <= (SIG_MEM_WR and not SIG_MEM_RD); -- mutually exclusive
    DEN <= SIG_DATA_ENA;

end STRUCT;


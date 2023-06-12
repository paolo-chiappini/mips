library ieee;
use ieee.std_logic_1164.all;

entity LOG_SHIFTER_32 is
    port (
        X        : in  std_logic_vector(31 downto 0); 
        SHAMT    : in  std_logic_vector(4 downto 0); 
        SHIFT_OP : in  std_logic_vector(1 downto 0);
        Y        : out std_logic_vector(31 downto 0)
    ); 
end LOG_SHIFTER_32;

architecture STRUCT of LOG_SHIFTER_32 is
    component DRCU_N is
        generic ( N : integer := 32 ); 
        port (
            X      : in  std_logic_vector(N - 1 downto 0);
            INVERT : in  std_logic; 
            Y      : out std_logic_vector(N - 1 downto 0)
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
    
    signal IN_STAGE_1  : std_logic_vector(31 downto 0);
    signal OUT_STAGE_1 : std_logic_vector(31 downto 0);
    signal OUT_STAGE_2 : std_logic_vector(31 downto 0);
    signal OUT_STAGE_3 : std_logic_vector(31 downto 0);
    signal OUT_STAGE_4 : std_logic_vector(31 downto 0);
    signal OUT_STAGE_5 : std_logic_vector(31 downto 0);
    signal SIG_FILL    : std_logic; 
    signal SIG_ENABLE  : std_logic_vector(4 downto 0); 
    signal SIG_LEFT    : std_logic; 
begin
    SIG_LEFT <= (SHIFT_OP(0) and (not SHIFT_OP(1))); 

    SIG_FILL <= X(31) when (SHIFT_OP(0) and SHIFT_OP(1)) = '1' else '0'; -- is sra
    SIG_ENABLE <= "00000" when (SHIFT_OP(0) or SHIFT_OP(1)) = '0' else SHAMT; -- is no_shift 

    -- D(ata) R(eversal) CU 1
    U0 : DRCU_N 
        generic map ( N => 32 )
        port map (
            X => X, 
            INVERT => SIG_LEFT, 
            Y => IN_STAGE_1
        ); 

    -- stage 1
    U1 : SHIFTER_N_M 
        generic map ( N => 32, M => 1 )
        port map (
            X => IN_STAGE_1, 
            Y => OUT_STAGE_1, 
            ENABLE => SIG_ENABLE(0), 
            FILL => SIG_FILL
        ); 

    -- stage 2
    U2 : SHIFTER_N_M 
    generic map ( N => 32, M => 2 )
    port map (
        X => OUT_STAGE_1, 
        Y => OUT_STAGE_2, 
        ENABLE => SIG_ENABLE(1), 
        FILL => SIG_FILL
    ); 

    -- stage 3
    U3 : SHIFTER_N_M 
        generic map ( N => 32, M => 4 )
        port map (
            X => OUT_STAGE_2, 
            Y => OUT_STAGE_3, 
            ENABLE => SIG_ENABLE(2), 
            FILL => SIG_FILL
        ); 

    -- stage 4
    U4 : SHIFTER_N_M 
    generic map ( N => 32, M => 8 )
    port map (
        X => OUT_STAGE_3, 
        Y => OUT_STAGE_4, 
        ENABLE => SIG_ENABLE(3), 
        FILL => SIG_FILL
    ); 

    -- stage 5
    U5 : SHIFTER_N_M 
    generic map ( N => 32, M => 16 )
    port map (
        X => OUT_STAGE_4, 
        Y => OUT_STAGE_5, 
        ENABLE => SIG_ENABLE(4), 
        FILL => SIG_FILL
    ); 

    -- DRCU 2
    U6 : DRCU_N 
        generic map ( N => 32 )
        port map (
            X => OUT_STAGE_5, 
            INVERT => SIG_LEFT, 
            Y => Y
        ); 
end STRUCT;


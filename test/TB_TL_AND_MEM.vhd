LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_TL_AND_MEM IS
END TB_TL_AND_MEM;
 
ARCHITECTURE behavior OF TB_TL_AND_MEM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MIPS_32
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         IADDR : OUT  std_logic_vector(31 downto 0);
         IDATA : IN  std_logic_vector(31 downto 0);
         IEN : OUT  std_logic;
         DADDR : OUT  std_logic_vector(31 downto 0);
         DOUT : OUT  std_logic_vector(31 downto 0);
         DIN : IN  std_logic_vector(31 downto 0);
         DOP : OUT  std_logic;
         DEN : OUT  std_logic
        );
    END COMPONENT;
    
    component MEMORY is
      port(
         CLK: in std_logic;
         RST: in std_logic;
         
         IEN: in std_logic;
         DEN: in std_logic;
         DOP: in std_logic;
         
         IADDR: in std_logic_vector(31 downto 0);
         IDATA: out std_logic_vector(31 downto 0);
         
         DADDR: in std_logic_vector(31 downto 0);
         DOUT: out std_logic_vector(31 downto 0);
         
         DIN: in std_logic_vector(31 downto 0)
      );
   end component;

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal IDATA : std_logic_vector(31 downto 0);
   signal DIN : std_logic_vector(31 downto 0);

 	--Outputs
   signal IADDR : std_logic_vector(31 downto 0);
   signal IEN : std_logic;
   signal DADDR : std_logic_vector(31 downto 0);
   signal DOUT : std_logic_vector(31 downto 0);
   signal DOP : std_logic;
   signal DEN : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MIPS_32 PORT MAP (
          CLK => CLK,
          RST => RST,
          IADDR => IADDR,
          IDATA => IDATA,
          IEN => IEN,
          DADDR => DADDR,
          DOUT => DOUT,
          DIN => DIN,
          DOP => DOP,
          DEN => DEN
        );

   U0: MEMORY port map (
      CLK => CLK, 
      RST => RST, 
      IADDR => IADDR, 
      IDATA => IDATA, 
      IEN => IEN, 
      DADDR => DADDR, 
      DOUT => DIN,
      DIN => DOUT, 
      DOP => DOP,
      DEN => DEN 
   ); 

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		RST <= '1';
		wait for 100 ns; 
		
		RST <= '0'; 
      wait;
   end process;

END;

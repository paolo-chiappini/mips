LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_MIPS_32_LOGIC IS
END TB_MIPS_32_LOGIC;
 
ARCHITECTURE behavior OF TB_MIPS_32_LOGIC IS 
 
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
    

   --Inputs
   signal CLK : std_logic;
   signal RST : std_logic;
   signal IDATA : std_logic_vector(31 downto 0);
   signal DIN : std_logic_vector(31 downto 0);

 	--Outputs
   signal IADDR : std_logic_vector(31 downto 0);
   signal IEN : std_logic;
   signal DADDR : std_logic_vector(31 downto 0);
   signal DOUT : std_logic_vector(31 downto 0);
   signal DOP : std_logic;
   signal DEN : std_logic;
 
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

	process
	begin
		CLK <= '1';
		wait for 25 ns;
		CLK <= '0';
		wait for 25 ns;
	end process;
	
   -- Stimulus process
   stim_proc: process
   begin		
		RST   <= '1';
		IDATA <= (others => '0');
		DIN   <= (others => '0');
      wait for 50 ns;
		
		RST   <= '0';
      wait for 50 ns;
		
		-- addi $t3, $t3, 145
		IDATA <= x"216b0091";
		wait for 50 ns;
		
		-- addi $t4, $t4, 8
		IDATA <= x"218c0008";
		wait for 50 ns;
		
		-- xor $t7, $t3, $t4
		IDATA <= x"016c7826";
		wait for 50 ns;
		
		-- andi $t7, $t3, 100
		IDATA <= x"316f0064";
		wait for 50 ns;
		
		-- andi $t7, $t3, 128
		IDATA <= x"316f0080";
		wait for 50 ns;
		
		-- xori $t5, $t7, 128
		IDATA <= x"39ed0080";
		wait for 50 ns;
		
		-- xori $t5, $t7, 1
		IDATA <= x"39ed0001";
		wait for 50 ns;
		
		-- xori $t5, $t7, 65535
		IDATA <= x"39edffff";
		wait for 50 ns;
		
		-- ori $t5, $t7, 65535
		IDATA <= x"354dffff";
		wait for 50 ns;
		
		wait;
   end process;

END;
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_MIPS_32_SL IS
END TB_MIPS_32_SL;
 
ARCHITECTURE behavior OF TB_MIPS_32_SL IS 
 
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
		
		-- addi $t3, $t3, 100
		IDATA <= x"216b0064";
		wait for 50 ns;
		
		-- addi $t4, $t4, 20
		IDATA <= x"218c0014";
		wait for 50 ns;
		
		-- sltu $t6, $t4, $t5
		IDATA <= x"018d702b";
		wait for 50 ns;
		
		-- sltu $t6, $t5, $t4
		IDATA <= x"01ac702b";
		wait for 50 ns;
		
		-- sltu $t7, $s0, $s1
		IDATA <= x"0211782b";
		wait for 50 ns;
		
		-- lui $s0, 65535
		IDATA <= x"3c10ffff";
		wait for 50 ns;
		
		-- ori $s0, $s0, 23
		IDATA <= x"36100017";
		wait for 50 ns;
		
		-- sltu $t7, $s0, $t3
		IDATA <= x"020b782b";
		wait for 50 ns;
		
		-- sltu $t7, $t3, $s0
		IDATA <= x"0170782b";
		wait for 50 ns;
		
		-- slti $t7, $t3, 50
		IDATA <= x"296f0032";
		wait for 50 ns;
		
		-- slti $t7, $t3, 220
		IDATA <= x"296f00dc";
		wait for 50 ns;
		
		-- slti $t7, $t3, 120
		IDATA <= x"296f0078";
		wait for 50 ns;
		
		-- sltiu $t7, $t3, 32767
		IDATA <= x"2d6f7fff";
		wait for 50 ns;
		
		-- sltiu $t7, $t3, 50
		IDATA <= x"2d6f0032";
		wait;
   end process;

END;
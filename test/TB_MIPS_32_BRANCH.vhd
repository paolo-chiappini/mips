LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_MIPS_32_BRANCH IS
END TB_MIPS_32_BRANCH;
 
ARCHITECTURE behavior OF TB_MIPS_32_BRANCH IS 
 
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
		
		-- j 1
		IDATA <= x"08000001";
		wait for 50 ns;
		
		IDATA <= x"00000000";
		wait for 50 ns;
		
		-- j 100
		IDATA <= x"08000064";
		wait for 50 ns;
		
		IDATA <= x"00000000";
		wait for 50 ns;
		
		-- j 67108863
		IDATA <= x"0BFFFFFF";
		wait for 50 ns;
		
		IDATA <= x"00000000";
		wait for 50 ns;
		
		-- lui $t0, 1234
		IDATA <= x"3c0804d2";
		wait for 50 ns;
		
		-- ori $t0, $t0, 456
		IDATA <= x"350801c8";
		wait for 50 ns;
		
		-- jr $t0
		IDATA <= x"01000008";
		wait for 50 ns;
		
		IDATA <= x"00000000";
		wait for 50 ns;
		
		-- jr $ra
		IDATA <= x"03e00008";
		wait for 50 ns;
		
		IDATA <= x"00000000";
		wait for 50 ns;
		
		-- jal 67108863
		IDATA <= x"0FFFFFFF";
		wait for 50 ns;
		
		-- addi $t0, $ra, 0
		IDATA <= x"23e80000";
		wait for 50 ns;
		
		-- jr $ra
		-- IDATA <= x"03e00008";
		-- wait for 50 ns;
		
		-- addi $t2, $t2, 1245
		IDATA <= x"214a04dd";
		wait for 50 ns;
		
		-- beq $t2, $t2, 1
		IDATA <= x"114a0001";
		wait for 50 ns;
		
		-- bne $t2, $t2, 1
		IDATA <= x"154a0001";
		wait for 50 ns;
		wait;
   end process;

END;
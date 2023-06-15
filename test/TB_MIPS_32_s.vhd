LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_MIPS_32_S IS
END TB_MIPS_32_S;
 
ARCHITECTURE behavior OF TB_MIPS_32_S IS 
 
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
		
		-- addi $t3, $t3, 24
		IDATA <= x"216b0018";
		wait for 50 ns;
		
		-- addi $t4, $t4, 8
		IDATA <= x"218c0008";
		wait for 50 ns;
		
		-- sll $t1, $t3, 4
		IDATA <= x"000b4900";
		wait for 50 ns;
		
		-- sll $t1, $t3, 1
		IDATA <= x"000b4840";
		wait for 50 ns;
		
		-- sll $t1, $t3, 31
		IDATA <= x"000b4fc0";
		wait for 50 ns;
		
		-- srl $t4, $t3, 10
		IDATA <= x"000b6282";
		wait for 50 ns;
		
		-- srl $t4, $t3, 2
		IDATA <= x"000b6082";
		wait for 50 ns;
		
		-- srl $t4, $t3, 0
		IDATA <= x"000b6002";
		wait for 50 ns;
		
		-- sra $t4, $t3, 1
		IDATA <= x"000b6043";
		wait for 50 ns;
		
		-- lui $t4, 65535
		IDATA <= x"3c0cffff";
		wait for 50 ns;
		
		-- sra $t4, $t4, 16
		IDATA <= x"000c6403";
		wait for 50 ns;
		
		-- now set if less ...
		-- slt $t4, $t4, $t3
		IDATA <= x"018b782a";
		wait for 50 ns;
		
		-- slt $t4, $t3, $t4
		IDATA <= x"016c782a";
		wait for 50 ns;
		
		-- slt $t5, $t5, $t5
		IDATA <= x"01ad682a";
		wait for 50 ns;
		
		-- slt $t5, $t6, $t3
		IDATA <= x"01cb682a";
		wait for 50 ns;
		
		-- add $t4, $t7, $t4
		IDATA <= x"01ec6020";
		wait for 50 ns;
		
		-- slt $t5, $t4, $t7
		IDATA <= x"018f682a";
		
		wait;
   end process;

END;
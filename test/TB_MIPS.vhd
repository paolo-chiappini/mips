LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_MIPS_32 IS
END TB_MIPS_32;
 
ARCHITECTURE behavior OF TB_MIPS_32 IS 
 
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
		
		-- addi $t0, $t0, 4
		IDATA <= x"21080004";
		wait for 50 ns;
		
		-- addi $t1, $t1, 8
		IDATA <= x"21290008";
		wait for 50 ns;
		
		-- addi $t2, $t1, $t0
		IDATA <= x"01285020";
		wait for 50 ns;
		
		-- sub $t3, $t1, $t0
		IDATA <= x"01285822";
		wait for 50 ns;
		
		-- and $t4, $t2, $t1
		IDATA <= x"01496024";
		wait for 50 ns;
		
		-- lui $t5, 123
		IDATA <= x"3c0d007b";
		wait for 50 ns;
		
		-- addi $t0, $t5, 8
		IDATA <= x"21a80008";
		wait for 50 ns;
		
		-- addi $t1, $t1, 500
		IDATA <= x"212901f4";
		wait for 50 ns;
		
		-- sub $t3, $t0, $t1
		IDATA <= x"01095822";
		wait for 50 ns;
		
		

      wait;
   end process;

END;

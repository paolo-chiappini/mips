
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_REG_UNIT IS
END TB_REG_UNIT;
 
ARCHITECTURE behavior OF TB_REG_UNIT IS 
 
 
    COMPONENT REG_UNIT
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         WR_REG : IN  std_logic;
         JAL : IN  std_logic;
         DST_REG : IN  std_logic;
         PC_IN : IN  std_logic_vector(0 to 31);
         WB_IN : IN  std_logic_vector(0 to 31);
         RS : IN  std_logic_vector(0 to 4);
         RT : IN  std_logic_vector(0 to 4);
         RD : IN  std_logic_vector(0 to 4);
         D0 : OUT  std_logic_vector(0 to 31);
         D1 : OUT  std_logic_vector(0 to 31)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic;
   signal RST : std_logic;
   signal WR_REG : std_logic;
   signal JAL : std_logic;
   signal DST_REG : std_logic;
   signal PC_IN : std_logic_vector(0 to 31);
   signal WB_IN : std_logic_vector(0 to 31);
   signal RS : std_logic_vector(0 to 4);
   signal RT : std_logic_vector(0 to 4);
   signal RD : std_logic_vector(0 to 4);

 	--Outputs
   signal D0 : std_logic_vector(0 to 31);
   signal D1 : std_logic_vector(0 to 31);

   -- Clock period definitions
   constant CLK_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: REG_UNIT PORT MAP (
          CLK => CLK,
          RST => RST,
          WR_REG => WR_REG,
          JAL => JAL,
          DST_REG => DST_REG,
          PC_IN => PC_IN,
          WB_IN => WB_IN,
          RS => RS,
          RT => RT,
          RD => RD,
          D0 => D0,
          D1 => D1
        );

   -- Stimulus process
   stim_proc: process
   begin		
		RST <= '1'; -- reset
		CLK <= '0';
      wait for CLK_period/2;
		
		CLK <= '1';
		wait for CLK_period/2;
		
		CLK <= '0';
		wait for CLK_period/2;
		
		CLK <= '1';
      wait for CLK_period/2;
		
		WR_REG <= '1';
		JAL <= '0';
		DST_REG <= '1'; -- writes in RD
		
		RD <= "10001";
		WB_IN <= x"aaaaaaaa";
		
		RS <= "00000";
		RT <= "01110";
		
		
		
		RST <= '0'; -- stop reset
		CLK <= '0';
      wait for CLK_period/2;
		
		CLK <= '1';
		wait for CLK_period/2;
		
		DST_REG <= '0'; -- write in RT
		
		
		WB_IN <= x"bbbbbbbb";
		
		CLK <= '0';
      wait for CLK_period/2;
		
		CLK <= '1';
		wait for CLK_period/2;
		
		WR_REG <= '0'; -- stop writing
		DST_REG <= '0';
		
		
		
		CLK <= '0';
      wait for CLK_period/2;
		
		RS <= "10001"; -- show on D0 the contents of 10001
		RT <= "01110";
		
		CLK <= '1';
		wait for CLK_period/2;
		
		WR_REG <= '1'; -- write in register 31 the value of PC_in
		PC_IN <= x"CCCCCCCC";
		JAL <= '1';
		
		CLK <= '0';
      wait for CLK_period/2;
		
		CLK <= '1';
		wait for CLK_period/2;
		
		WR_REG <= '0';
		RS<= "11111"; -- show on D0 the contents of register 31
		
		CLK <= '0';
      wait for CLK_period/2;
		
		CLK <= '1';
		wait for CLK_period/2;
		
		CLK <= '0';
      wait;
   end process;

END;

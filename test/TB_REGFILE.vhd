
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY REGFILE_TB IS
END REGFILE_TB;
 
ARCHITECTURE behavior OF REGFILE_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    component REGFILE
    port(
         WRREG : in  std_logic;
         CLK : in  std_logic;
         RST : in  std_logic;
         DIN : in  std_logic_vector(0 to 31);
         RS : in  std_logic_vector(0 to 4);
         RT : in  std_logic_vector(0 to 4);
         RD : in  std_logic_vector(0 to 4);
         D0 : out  std_logic_vector(0 to 31);
         D1 : out  std_logic_vector(0 to 31)
        );
    end component;
    

   --Inputs
   signal WRREG : std_logic;
   signal CLK : std_logic;
   signal RST : std_logic;
   signal DIN : std_logic_vector(0 to 31);
   signal RS : std_logic_vector(0 to 4);
   signal RT : std_logic_vector(0 to 4);
   signal RD : std_logic_vector(0 to 4);

 	--Outputs
   signal D0 : std_logic_vector(0 to 31);
   signal D1 : std_logic_vector(0 to 31);

	constant HALF_CLOCK : time := 20 ns;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: REGFILE port map (
          WRREG => WRREG,
          CLK => CLK,
          RST => RST,
          DIN => DIN,
          RS => RS,
          RT => RT,
          RD => RD,
          D0 => D0,
          D1 => D1
        );

   process
   begin
		-- reset
		
		RST <= '1';
		CLK <= '0';
		
		wait for HALF_CLOCK;

		CLK <= '1';
		
		wait for HALF_CLOCK;
		
		CLK <= '0';
		
		wait for HALF_CLOCK;
		
		RST <= '0';
		CLK <= '1';
		
		wait for HALF_CLOCK;
		
		-- WRITES register 16
		
		WRREG <= '1';
		RD <= "10000";
		DIN <= x"ABCDEF01";
		
		CLK <= '0';
		
		wait for HALF_CLOCK;

		CLK <= '1';
		
		wait for HALF_CLOCK;
		
		WRREG <= '0';
		CLK <= '0';
		
		wait for HALF_CLOCK;
		
		-- READS register 16
		
		RS <= "10000";
		CLK <= '1';
		
		wait for HALF_CLOCK;
		
		CLK <= '0';
		
		wait for HALF_CLOCK;
		-- READS registers 1 and 16
		
		RS <= "00001";
		RT <= "10000";
		
		CLK <= '1';
		
		wait for HALF_CLOCK;
		
		-- WRITES register 1
		
		WRREG <= '1';
		RD <= "00001";
		DIN <= x"AAAAAAAA";
		
		CLK <= '0';
		
		wait for HALF_CLOCK;

		CLK <= '1';
		
		wait for HALF_CLOCK;
		WRREG <= '0';
		CLK <= '0';
	
		wait;
   end process;

END;

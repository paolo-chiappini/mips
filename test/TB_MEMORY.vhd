
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

ENTITY TB_MEMORY IS
END TB_MEMORY;
 
ARCHITECTURE behavior OF TB_MEMORY IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMORY
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         IEN : IN  std_logic;
         DEN : IN  std_logic;
         DOP : IN  std_logic;
         IADDR : IN  std_logic_vector(31 downto 0);
         IDATA : OUT  std_logic_vector(31 downto 0);
         DADDR : IN  std_logic_vector(31 downto 0);
         DOUT : OUT  std_logic_vector(31 downto 0);
         DIN : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic;
   signal RST : std_logic;
   signal IEN : std_logic;
   signal DEN : std_logic;
   signal DOP : std_logic;
   signal IADDR : std_logic_vector(31 downto 0);
   signal DADDR : std_logic_vector(31 downto 0);
   signal DIN : std_logic_vector(31 downto 0);

 	--Outputs
   signal IDATA : std_logic_vector(31 downto 0);
   signal DOUT : std_logic_vector(31 downto 0);

	constant CLOCK_PERIOD : time := 5 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMORY PORT MAP (
          CLK => CLK,
          RST => RST,
          IEN => IEN,
          DEN => DEN,
          DOP => DOP,
          IADDR => IADDR,
          IDATA => IDATA,
          DADDR => DADDR,
          DOUT => DOUT,
          DIN => DIN
        );

   process is
		variable I : integer := 128; -- start from text
   begin
		RST <= '1';
		
		CLK <= '0';
		wait for CLOCK_PERIOD/2;
		
		CLK <= '1';
		wait for CLOCK_PERIOD/2;
		
		RST <= '0';
		
		DOP <= '0'; -- read
		DEN <= '0'; 
		IEN <= '1'; -- instruction
		
		CLK <= '0';
		wait for CLOCK_PERIOD/2;
		
		-- PRINTS TEXT SEGMENT
		while I < 512 loop 
			IADDR <= std_logic_vector(to_unsigned(I, IADDR'length));
			CLK <= '1';
			wait for CLOCK_PERIOD/2;
			I := I + 4;
			CLK <= '0';
			wait for CLOCK_PERIOD/2;
		end loop;
		CLK <= '1';
		wait for CLOCK_PERIOD/2;
		
		-- WRITE AND READ TEST
		
		DOP <= '1'; -- write
		DEN <= '1'; 
		
		DADDR <= x"00000000";
		DIN <= x"ffffffff";
		
		CLK <= '0';
		wait for CLOCK_PERIOD/2;
		
		CLK <= '1';
		wait for CLOCK_PERIOD/2;
		
		DOP <= '0'; -- read
		IEN <= '1'; -- read on IDATA
		IADDR <= x"00000000";
		
		DEN <= '0'; 
		CLK <= '0';
		wait for CLOCK_PERIOD/2;
		
		CLK <= '1';
		wait for CLOCK_PERIOD/2;
		
		CLK <= '0';
		wait;
   end process;

END;

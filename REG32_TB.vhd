
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY REG32_TB IS
END REG32_TB;
 
ARCHITECTURE behavior OF REG32_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT REG32
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         EN : IN  std_logic;
         DIN : IN  std_logic_vector(0 to 31);
         DOUT : OUT  std_logic_vector(0 to 31)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic;
   signal RST : std_logic;
   signal EN : std_logic;
   signal DIN : std_logic_vector(0 to 31);

 	--Outputs
   signal DOUT : std_logic_vector(0 to 31);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
  uut: REG32 PORT MAP (
          CLK => CLK,
          RST => RST,
          EN => EN,
          DIN => DIN,
          DOUT => DOUT
  );

  process
  begin
    
	 RST <= '1';
	 CLK <= '0';
    
	 wait for 10 ns;
	 
	 CLK <= '1';
    
	 wait for 10 ns;
	 
	 CLK <= '0';
    
	 wait for 10 ns;
	 
	 RST <= '0';
    DIN <= x"AAAAAAAA";
    EN <= '1';
    CLK <= '1';
	
	 wait for 5 ns;
	 EN <= '0';
    wait for 5 ns;

    DIN <= x"FFFFFFFF";
    CLK <= '0';

    wait for 5 ns;
	 en <= '1';
	 wait for 5 ns;
    CLK <= '1';

    wait for 10 ns;

    CLK <= '0';

    wait;

  end process;

END;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity MEMORY is
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
end MEMORY;

architecture Behavioral of MEMORY is
	type RAM_T is array (0 to 1023) of std_logic_vector(7 downto 0);
   signal RAM : RAM_T;
begin

	process(IADDR) is
		variable I_INDEX : integer := 0;
	begin
		if(IEN = '1') then
				I_INDEX := to_integer(unsigned(IADDR));
								
				if(I_INDEX + 4 < 1024) then
					IDATA <= RAM(I_INDEX)     & 
								RAM(I_INDEX + 1) & 
								RAM(I_INDEX + 2) & 
								RAM(I_INDEX + 3);
				end if;
			end if;
	end process;
	process(CLK, RST) is
		variable LINE_v : line;
		file READ_FILE : text;
		variable DATA : std_logic_vector(31 downto 0);
		variable MORE_DATA: boolean;
		
		variable I : integer := 0;
		
		
		variable D_INDEX : integer := 0;
	begin		
		if(CLK'event and CLK = '1') then
		
			-- MEMORY INITIALIZATION
			if(RST = '1') then
				I := 0;
				DOUT <= (others => '0');
				
				file_open(READ_FILE, "initial_mem_state.txt", read_mode);
				
				while not endfile(READ_FILE) loop
					readline(READ_FILE, LINE_v);
					read(LINE_v, DATA, MORE_DATA);
					if(not MORE_DATA) then
						exit;
					end if;
					
					RAM(I) <= DATA(31 downto 24); -- big endian
					I := I + 1;
					RAM(I) <= DATA(23 downto 16);
					I := I + 1;
					RAM(I) <= DATA(15 downto 8);
					I := I + 1;
					RAM(I) <= DATA(7 downto 0);
					I := I + 1;
				end loop;
			
				file_close(READ_FILE);
				
			-- ACCESS TO MEMORY
			else
				-- WRITE
				if(DOP = '1') then 
					if(DEN = '1') then
						D_INDEX := to_integer(unsigned(DADDR));
						
						if(D_INDEX + 4 < 1024) then
							RAM(D_INDEX)     <= DIN(31 downto 24);
							RAM(D_INDEX + 1) <= DIN(23 downto 16);
							RAM(D_INDEX + 2) <= DIN(15 downto 8);
							RAM(D_INDEX + 3) <= DIN(7 downto 0);
						end if;
						
					end if;
				end if;
			end if;
			else if(CLK'event and CLK = '0') then
				if(DOP = '0' and DEN = '1') then
					D_INDEX := to_integer(unsigned(DADDR));
		
					if(D_INDEX + 4 < 1024) then
						DOUT <= RAM(D_INDEX)     & 
								RAM(D_INDEX + 1) &
								RAM(D_INDEX + 2) &
								RAM(D_INDEX + 3);
					end if;	
				end if;
				end if;
		end if;
	end process;

end Behavioral;

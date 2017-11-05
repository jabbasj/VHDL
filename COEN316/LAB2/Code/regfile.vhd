library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.ALL;

-- Register implementation based on my stack from COEN 313
-- Assumptions:
--	   			Inverted outputs
--				WRITE simply overwrites data


entity regfile is

	port( 
	--inputs
		DATA_IN : in std_logic_vector(31 downto 0);
		RESET : in std_logic;
		CLK : in std_logic;
		WRITE : in std_logic;
		READ_A : in std_logic_vector(4 downto 0);
		READ_B : in std_logic_vector(4 downto 0);
		WRITE_ADDRESS : in std_logic_vector(4 downto 0);
		
	--outputs
		OUT_A : out std_logic_vector(31 downto 0);
		OUT_B : out std_logic_vector(31 downto 0));
	
end regfile ;


architecture lab2 of regfile is

	type mem_type is array(31 downto 0) of std_logic_vector(31 downto 0);
	
	signal registers : mem_type := (others => (others => '0'));
	
	constant top_ptr : integer:= 0;
	constant bot_ptr : integer:= 31;
	
	begin
	
		OUT_A <= registers(to_integer(unsigned(READ_A)));
		OUT_B <= registers(to_integer(unsigned(READ_B)));
		
		--Reset/Writefunctionality (in order of priority)
		func : process(CLK, WRITE, RESET) 
			
			variable temp_index: integer := 0;
			
			begin
			
				-- Asynchronous reset
				-- Resets EVERYTHING, stack registers & shadow registers
				if (RESET = '0') then
					
						for i in top_ptr to bot_ptr loop					
							registers(i) <= (others => '0');
						end loop;
				
				-- Synchronous with rising edge of CLK
				elsif (rising_edge(CLK)) then				
											
					-- WRITE (force)
					-- This function will overwrite data at register[write_address]
					if (WRITE = '0') then
						
						temp_index := to_integer(unsigned(WRITE_ADDRESS));
						
						-- check if write_address corresponds to a valid entry in regfile
						if ((bot_ptr >= temp_index) and (temp_index >= top_ptr)) then
							
							registers(temp_index) <= DATA_IN;
						
						end if;
					
					else
						-- do nothing						
					end if;
				else
					-- do nothing
				end if;				
		end process;
		
end lab2;

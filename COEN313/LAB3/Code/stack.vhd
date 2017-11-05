library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

-- Stack implementation according to COEN 313 specs
-- Assumptions:
--	   			Inverted outputs
-- 				SAVE clears stack by saving to shadow registers, so you don't have to pop to push again
--				WRITE simply overwrites data, does not increment stack counter (data will be erased by push/pop operations)


entity stack is

	port( 
		DATA_IN : in std_logic_vector(3 downto 0);
		RESET : in std_logic;
		CLK : in std_logic;
		WRITE : in std_logic;
		READ_A : in std_logic_vector(1 downto 0);
		READ_B : in std_logic_vector(1 downto 0);
		WRITE_ADDRESS : in std_logic_vector(1 downto 0);
		PUSH : in std_logic;
		POP : in std_logic;
		SAVE : in std_logic;
		RESTORE: in std_logic;
		
		TOP_OUT : out std_logic_vector(3 downto 0);
		FULL_OUT : out std_logic;
		EMPTY_OUT : out std_logic;
		OUT_A : out std_logic_vector(3 downto 0);
		OUT_B : out std_logic_vector(3 downto 0));
	
end stack ;


architecture lab3 of stack is

	type mem_type is array(3 downto 0) of std_logic_vector(3 downto 0);
	
	signal registers : mem_type := (others => (others => '0'));
	signal shadow_registers: mem_type := (others => (others => '0'));
	signal shadow_push_counter: integer := 0;
	signal full: std_logic := '1';
	signal empty: std_logic:= '0';
	signal push_counter : integer := 0;
	
	constant size : integer:= 4; --size of stack
	constant top_ptr : integer:= 0;
	constant bot_ptr : integer:= 3;
	
	begin
	
		FULL_OUT <= full;
		EMPTY_OUT <= empty;		
		TOP_OUT <= registers(top_ptr);
		OUT_A <= registers(to_integer(unsigned(READ_A)));
		OUT_B <= registers(to_integer(unsigned(READ_B)));
		
		--Push/Pop/Write/Restore/Save functionality (in order of priority)
		func : process(CLK, PUSH, POP, WRITE, RESTORE, SAVE, RESET) 
			
			variable temp_index: integer := 0;
			
			begin
			
				-- Asynchronous reset
				-- Resets EVERYTHING, stack registers & shadow registers
				if (RESET = '0') then
					
						for i in top_ptr to bot_ptr loop					
							registers(i) <= (others => 'Z');
							shadow_registers(i) <= (others => 'Z');
						end loop;
						
						full <= '1';
						empty <= '0';
						push_counter <= 0;
				
				-- Synchronous with rising edge of CLK
				elsif (rising_edge(CLK)) then				
					--PUSH
					if (full = '1' and PUSH = '0') then
						--Push on top of stack if PUSH is pressed and stack is not full
						
						-- Shift register values from top to bottom (r3 is now r2, r2 is now r1, r1 is now r0)
						for i in size-1 downto size - bot_ptr loop					
							registers(i) <= registers(i-1);					
						end loop;
						
						-- Add new data to the top of stack
						registers(top_ptr) <= DATA_IN;
						
						--Increment counter
						push_counter <= push_counter + 1;
						
						--Set full/empty flags
						if (push_counter = 3) then
							full <= '0';
							empty <= '1';
						else 
							full <= '1';
							empty <= '1';
						end if;
					
					-- POP
					elsif (empty = '1' and POP = '0') then
						--Pop top of stack if POP is pressed and stack is not empty
						
						-- Shift register values from bottom to top (r0 is now r1, r1 is now r2, r2 is now r3)
						for i in top_ptr to bot_ptr - 1 loop
							registers(i) <= registers(i+1);
						end loop;
						
						registers(bot_ptr) <= (others => 'Z');
						
						-- Decrement counter
						push_counter <= push_counter - 1;
						
						--Set full/empty flags
						if (push_counter = 1) then
							full <= '1';
							empty <= '0';
						else 
							full <= '1';
							empty <= '1';
						end if;
						
					-- WRITE (force)
					-- No regard for stack counter, this function is "hidden" from the stack and will overwrite data
					elsif (WRITE = '0') then
						
						temp_index := to_integer(unsigned(WRITE_ADDRESS));
						
						-- check if write_address corresponds to a valid entry in stack (not really necessay)
						if ((bot_ptr >= temp_index) and (temp_index >= top_ptr)) then
							
							registers(temp_index) <= DATA_IN;
						
						end if;
					
					-- RESTORE
					elsif (RESTORE = '0' and shadow_push_counter /= 0) then
					
						for i in top_ptr to bot_ptr loop					
							registers(i) <= shadow_registers(i);
						end loop;
						
						push_counter <= shadow_push_counter;
						
						if (shadow_push_counter = 0) then
							full <= '1';
							empty <= '0';
						elsif (shadow_push_counter = 4) then
							full <= '0';
							empty <= '1';
						else
							full <= '1';
							empty <= '1';
						end if;
					
					-- SAVE
					-- Copies contents to shadow_registers and clears the stack
					elsif (SAVE = '0') then
					
						for i in top_ptr to bot_ptr loop					
							shadow_registers(i) <= registers(i);
						end loop;
						
						shadow_push_counter <= push_counter;
						
						for i in top_ptr to bot_ptr loop					
							registers(i) <= (others => 'Z');
						end loop;
						
						push_counter <= 0;
						full <= '1';
						empty <= '0';
					
					else
						-- do nothing
						
					end if;
					
				end if;				
		end process;
		
end lab3;

library IEEE;
use IEEE.std_logic_1164.all;

entity alu1bit is

port(
	-- input of 1bit alu
	a, b, less, carry_in : in std_logic;
	
	add_sub : in std_logic ; -- 0 = add , 1 = sub
	logic_func : in std_logic_vector(1 downto 0 ) ;  -- 00 = AND, 01 = OR , 10 = XOR , 11 = NOR
	func : in std_logic_vector(1 downto 0 ) ;   -- 00 = lui, 01 = setless , 10 = arith , 11 = logic

	-- output of 1bit alu
	result : out std_logic;
	carry_out : out std_logic
);
	
end alu1bit ;

architecture lab1 of alu1bit is

begin

	main: process (a, b, less, carry_in, add_sub, logic_func, func)
	begin	
	
		-- switch based on func
		case func is 
			when "00" => --lui			
				result <= b;
				carry_out <= '0'; --no carry
				
			when "01" => --setless
			
				result <= less;
				carry_out <= (a AND (NOT b)) OR (a AND carry_in) OR ((NOT b) AND carry_in); -- invert b because we're doing substraction during setless, the carry_in will be '1' for the LSB (see carry_in_hack)
				
			when "10" => --arith (1-bit, 2's complement based) (add_sub decides if we invert b, carry_in will be 0 for the LSB for addition and 1 during substraction)
				
				result <= a XOR (b XOR add_sub) XOR carry_in;
				carry_out <= (a AND (b XOR add_sub)) OR (a AND carry_in) OR ((b XOR add_sub) AND carry_in); -- (b XOR add_sub) means invert b if add_sub is 1 (i.e. doing sub);
			
			when "11" => --logic (bit-wise, carries don't exist)
				
				case logic_func is 
				
					when "00" => --and					
						result <= a AND b;
						carry_out <= '0';
						
					when "01" => --or					
						result <= a OR b;
						carry_out <= '0';
						
					when "10" => --xor
						result <= a XOR b;
						carry_out <= '0';
					
					when "11" => --nor
						result <= a NOR b;
						carry_out <= '0';
						
					when others => 
						result <= '0';
						carry_out <= '0';
						
				end case;
				
			when others => 
				result <= '0';
				carry_out <= '0';
				
		end case;		
	
	end process;
	
end lab1;

library IEEE;
use IEEE.std_logic_1164.all;

entity alu1bitmostsignificant is

port(    
	-- input of 1bit alu most significant
	a, b, less, carry_in : in std_logic;
	
	add_sub : in std_logic ; -- 0 = add , 1 = sub
	logic_func : in std_logic_vector(1 downto 0 ) ;  -- 00 = AND, 01 = OR , 10 = XOR , 11 = NOR
	func : in std_logic_vector(1 downto 0 ) ;   -- 00 = lui, 01 = setless , 10 = arith , 11 = logic
	
	
	--output of 1bit alu most significant
	result : out std_logic;
	set : out std_logic;
	overflow: out std_logic	
);

end alu1bitmostsignificant ;

architecture lab1 of alu1bitmostsignificant is

-- reuse alu1bit implementation
component alu1bit
	port(
		a, b, less, carry_in, add_sub: in std_logic;
		logic_func : in std_logic_vector(1 downto 0 ) ;
		func : in std_logic_vector(1 downto 0 ) ;
		result, carry_out : out std_logic
	);
	end component;

	--extending functionality of alu1bit
	signal last_carry: std_logic;
	signal temp_result: std_logic;

begin

	--MSB alu works like alu1bit... but has extra features
	MSB: alu1bit
	port map (a => a, b => b, less => less, carry_in => carry_in, add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result, carry_out => last_carry);

	result <= temp_result;	
	
	-- setlessthan bit logic
	set <= a XOR (NOT b) XOR carry_in; --the MSB from substraction result is "set" to "less" at the LSB
	
	msb_extra: process (carry_in, last_carry, func) --, a, b, add_sub, temp_result)	
	begin		
		-- overflow logic
		if (func = "10") then -- arith
		
			overflow <= carry_in XOR last_carry;
		
		-- The overflow logic below WORKS but is unnecessary as the above line is more efficient
			-- if (add_sub = '0') then  -- add
			
				-- if (a /= b) then --opposite sign
					-- overflow <= '0';
					
				-- elsif ((a AND b) = '1') then --two negative
					-- overflow <= NOT temp_result;
					
				-- else --two positive 
					-- overflow <= temp_result;
				-- end if;				
			
			-- elsif (add_sub = '1') then --add_sub = 1 (i.e. sub)
			
				-- if (a = b) then --same sign
					-- overflow <= '0';
					
				-- elsif (a > b) then --negative a minus positive b
					-- overflow <= NOT temp_result;
				-- else 
					-- overflow <= temp_result;
				-- end if;
				
			-- else 			
				-- overflow <= '0';			
			-- end if;			
		else 
			overflow <= '0';
		
		end if;
	
	end process;

end lab1;

 -- explicitely link components to entities
configuration lab1 of alu1bitmostsignificant is
    for lab1      

		for MSB: alu1bit use entity work.alu1bit port map (
			a => a, b => b, less => less, add_sub => add_sub, carry_in => carry_in,logic_func => logic_func, func => func, result => result, carry_out => carry_out
		); end for;
    end for;
end configuration lab1;
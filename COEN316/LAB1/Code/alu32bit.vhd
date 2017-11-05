library IEEE;
use IEEE.std_logic_1164.all;

entity alu32bit is

port(
	
	-- input of 32bit alu
	a, b : in std_logic_vector(31 downto 0);	-- assuming SIGNED overflow logic, note: possible to get overflow even if you don't have output carry bit (so overflow logic should be done here or in MSB? by checking signs
	--a is x, b is y
	
	add_sub : in std_logic ; -- 0 = add , 1 = sub	
	logic_func : in std_logic_vector(1 downto 0 ) ;   -- 00 = AND, 01 = OR , 10 = XOR , 11 = NOR
	func : in std_logic_vector(1 downto 0 ) ;    -- 00 = lui, 01 = setless , 10 = arith , 11 = logic
	
	-- output of 32bit alu
	result : out std_logic_vector(31 downto 0) ;
	overflow : out std_logic ;
	zero : out std_logic

);
	
end alu32bit ;



architecture lab1 of alu32bit is

	constant logic_0: std_logic:= '0';
	signal carries: std_logic_vector(30 downto 0); 		--vector holding carries of addition/substraction
	signal set_bit: std_logic:= '0'; 					--taken from MSB and fed into LSB, if func is '01' (setless), it will be selected into result(0) 
	signal temp_result: std_logic_vector(31 downto 0); 	--holds results of all 1bit ALUs, used to compute Zero and LUI result masking
	signal carry_in_hack : std_logic := '0'; 			-- carry_in needs to be 1 for subs and for setless (01)
	
	component alu1bit
	port(
		a, b, less, carry_in, add_sub: in std_logic;
		logic_func : in std_logic_vector(1 downto 0 ) ;
		func : in std_logic_vector(1 downto 0 ) ;
		result, carry_out : out std_logic
	);
	end component;

	component alu1bitmostsignificant
	port(
		a, b, less, carry_in, add_sub: in std_logic;
		logic_func : in std_logic_vector(1 downto 0 ) ;
		func : in std_logic_vector(1 downto 0 ) ;
		result, set, overflow : out std_logic
	);
	end component;	

	begin
	
		-- hacky, but carry_in needs to be 1 for subs and for setless (01)
		carry_in_hack <= add_sub OR func(0);	
		
		-- if result is 000...000, zero is 1 else 0
		zero <= NOT( temp_result(0) OR temp_result(1) OR temp_result(2) OR temp_result(3) OR temp_result(4) OR temp_result(5) OR temp_result(6) OR temp_result(7) OR temp_result(8)
					 OR temp_result(9) OR temp_result(10) OR temp_result(11) OR temp_result(12) OR temp_result(13) OR temp_result(14) OR temp_result(15) OR temp_result(16) OR temp_result(17)
					 OR temp_result(18) OR temp_result(19) OR temp_result(20) OR temp_result(21) OR temp_result(22) OR temp_result(23) OR temp_result(24) OR temp_result(25) OR temp_result(26)
					  OR temp_result(28) OR temp_result(29) OR temp_result(30) OR temp_result(31));

					  
		-- portmap each 1bit together to form 32bit alu		
		
		alu0: alu1bit  --less is connected to the set_bit coming from MSB	--carry_in '1' when doing sub or slt											
		port map (a => a(0), b => b(0), less => set_bit, carry_in => carry_in_hack, add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(0), carry_out => carries(0));
		
		alu1: alu1bit  --less is '0' always except LSB
					   --carry_in of following 1bitALU is carry_out of previous one
		port map (a => a(1), b => b(1), less => logic_0, carry_in => carries(0), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(1), carry_out => carries(1));
		
		alu2: alu1bit
		port map (a => a(2), b => b(2), less => logic_0, carry_in => carries(1), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(2), carry_out => carries(2));
		
		alu3: alu1bit
		port map (a => a(3), b => b(3), less => logic_0, carry_in => carries(2), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(3), carry_out => carries(3));
		
		alu4: alu1bit
		port map (a => a(4), b => b(4), less => logic_0, carry_in => carries(3), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(4), carry_out => carries(4));
		
		alu5: alu1bit
		port map (a => a(5), b => b(5), less => logic_0, carry_in => carries(4), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(5), carry_out => carries(5));
		
		alu6: alu1bit
		port map (a => a(6), b => b(6), less => logic_0, carry_in => carries(5), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(6), carry_out => carries(6));
		
		alu7: alu1bit
		port map (a => a(7), b => b(7), less => logic_0, carry_in => carries(6), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(7), carry_out => carries(7));
		
		alu8: alu1bit
		port map (a => a(8), b => b(8), less => logic_0, carry_in => carries(7), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(8), carry_out => carries(8));
		
		alu9: alu1bit
		port map (a => a(9), b => b(9), less => logic_0, carry_in => carries(8), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(9), carry_out => carries(9));
		
		alu10: alu1bit
		port map (a => a(10), b => b(10), less => logic_0, carry_in => carries(9), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(10), carry_out => carries(10));
		
		alu11: alu1bit
		port map (a => a(11), b => b(11), less => logic_0, carry_in => carries(10), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(11), carry_out => carries(11));
		
		alu12: alu1bit
		port map (a => a(12), b => b(12), less => logic_0, carry_in => carries(11), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(12), carry_out => carries(12));
		
		alu13: alu1bit
		port map (a => a(13), b => b(13), less => logic_0, carry_in => carries(12), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(13), carry_out => carries(13));
		
		alu14: alu1bit
		port map (a => a(14), b => b(14), less => logic_0, carry_in => carries(13), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(14), carry_out => carries(14));
		
		alu15: alu1bit
		port map (a => a(15), b => b(15), less => logic_0, carry_in => carries(14), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(15), carry_out => carries(15));
		
		alu16: alu1bit
		port map (a => a(16), b => b(16), less => logic_0, carry_in => carries(15), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(16), carry_out => carries(16));
		
		alu17: alu1bit
		port map (a => a(17), b => b(17), less => logic_0, carry_in => carries(16), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(17), carry_out => carries(17));
		
		alu18: alu1bit
		port map (a => a(18), b => b(18), less => logic_0, carry_in => carries(17), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(18), carry_out => carries(18));
		
		alu19: alu1bit
		port map (a => a(19), b => b(19), less => logic_0, carry_in => carries(18), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(19), carry_out => carries(19));
		
		alu20: alu1bit
		port map (a => a(20), b => b(20), less => logic_0, carry_in => carries(19), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(20), carry_out => carries(20));
		
		alu21: alu1bit
		port map (a => a(21), b => b(21), less => logic_0, carry_in => carries(20), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(21), carry_out => carries(21));
		
		alu22: alu1bit
		port map (a => a(22), b => b(22), less => logic_0, carry_in => carries(21), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(22), carry_out => carries(22));
		
		alu23: alu1bit
		port map (a => a(23), b => b(23), less => logic_0, carry_in => carries(22), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(23), carry_out => carries(23));
		
		alu24: alu1bit
		port map (a => a(24), b => b(24), less => logic_0, carry_in => carries(23), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(24), carry_out => carries(24));
		
		alu25: alu1bit
		port map (a => a(25), b => b(25), less => logic_0, carry_in => carries(24), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(25), carry_out => carries(25));
		
		alu26: alu1bit
		port map (a => a(26), b => b(26), less => logic_0, carry_in => carries(25), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(26), carry_out => carries(26));
		
		alu27: alu1bit
		port map (a => a(27), b => b(27), less => logic_0, carry_in => carries(26), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(27), carry_out => carries(27));
		
		alu28: alu1bit
		port map (a => a(28), b => b(28), less => logic_0, carry_in => carries(27), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(28), carry_out => carries(28));
		
		alu29: alu1bit
		port map (a => a(29), b => b(29), less => logic_0, carry_in => carries(28), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(29), carry_out => carries(29));
	
		alu30: alu1bit
		port map (a => a(30), b => b(30), less => logic_0, carry_in => carries(29), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(30), carry_out => carries(30));

		--overflow is decided at the MSB, the set bit is routed to the LSB alu and used during the setless than func
		alu31: alu1bitmostsignificant
		port map (a => a(31), b => b(31), less => logic_0, carry_in => carries(30), add_sub => add_sub, logic_func => logic_func, func => func, result => temp_result(31), overflow => overflow, set => set_bit);
		
		--special case 
		alu32bitproc : process(func, temp_result) 		
		begin
			if (func = "00") then --lui
				result <= temp_result AND "11111111111111110000000000000000"; --mask lowest 16bits during LUI
				
			else
				result <= temp_result;
			end if;			
			
		end process;
		
end lab1;

 -- explicitely link components to entities
configuration lab1 of alu32bit is
    for lab1
     
		for alu0, alu1, alu2, alu3, alu4, alu5, alu6, alu7, alu8, alu9, alu10, alu11, alu12, alu13, alu14, alu15, alu16, alu17, alu18, alu19, alu20, alu21, alu22, alu23, alu24, alu25, alu26, alu27, alu28, alu29, alu30: alu1bit use entity work.alu1bit port map (
			a => a, b => b, less => less, add_sub => add_sub, carry_in => carry_in, logic_func => logic_func, func => func, result => result, carry_out => carry_out
		); end for;

		for alu31: alu1bitmostsignificant use entity work.alu1bitmostsignificant port map (
			a => a, b => b, less => less, add_sub => add_sub, carry_in => carry_in,logic_func => logic_func, func => func, result => result, set => set, overflow => overflow
		); end for;
    end for;
end configuration lab1;

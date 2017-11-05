library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity reg_inc_load is 
	port(	din : in std_logic_vector(3 downto 0);
			clk : in std_logic;
			load : in std_logic;
			inc : in std_logic;
			q : out std_logic_vector(3 downto 0)
		);	
end;

architecture my_arch of reg_inc_load is

	signal my_register : std_logic_vector(3 downto 0) := (others => '0');
	
	begin
		
		q <= my_register;
		
		func : process (din, clk, load, inc) 		
			begin
			
			if (rising_edge(clk)) then
			
				if (load = '1') then
				
					my_register <= din;
				
				elsif (inc = '1') then
				
					my_register <= my_register + 1;
			
				end if;
			
			end if;
			
			end process;

end my_arch;
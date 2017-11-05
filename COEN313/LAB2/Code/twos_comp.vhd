library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; -- for the “+” operator

entity twos_comp is
port(
	input: in std_logic_vector(7 downto 0);
	output: out std_logic_vector(7 downto 0));
end twos_comp;

architecture twos_comp_arch of twos_comp is
signal sig1: std_logic_vector(7 downto 0);
signal temp: std_logic_vector(7 downto 0);

component inverter
port(
	in1: in std_logic;
	out1: out std_logic
);
end component;

component adder
port(
	in1, in2 : in std_logic_vector(7 downto 0);
	out1 : out std_logic_vector(7 downto 0)
);
end component;

begin
	
	unit1: inverter
	port map (in1 => input(0), out1 => sig1(0));
	unit2: inverter
	port map (in1 => input(1), out1 => sig1(1));	
	unit3: inverter
	port map (in1 => input(2), out1 => sig1(2));	
	unit4: inverter
	port map (in1 => input(3), out1 => sig1(3));
	unit5: inverter
	port map (in1 => input(4), out1 => sig1(4));
	unit6: inverter
	port map (in1 => input(5), out1 => sig1(5));
	unit7: inverter
	port map (in1 => input(6), out1 => sig1(6));
	unit8: inverter
	port map (in1 => input(7), out1 => sig1(7));

	unit9: adder
	port map (in1 => sig1, in2 => "00000001", out1 => temp);
	
process(input, temp)
begin
	if (input(7) = '1') then output <= not(temp);
	else output <= not(input);
	end if;
end process;

end twos_comp_arch;





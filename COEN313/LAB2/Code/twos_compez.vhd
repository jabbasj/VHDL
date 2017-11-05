library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; -- for the “+” operator

entity twos_compez is
port(
	input: in std_logic_vector(7 downto 0);
	output: out std_logic_vector(7 downto 0));
end twos_compez;

architecture twos_comp_arch of twos_compez is

begin

process(input)
begin
	if (input(7) = '1') then output <= (not(input) + "00000001");
	else output <= input;
	end if;
end process;


end twos_comp_arch;





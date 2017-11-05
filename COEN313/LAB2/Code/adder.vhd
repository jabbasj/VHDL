library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity adder is
port(
	in1, in2: in std_logic_vector(7 downto 0);
	out1: out std_logic_vector(7 downto 0)
);
end adder;

architecture adder_arch of adder is
begin
	out1 <= in1 + in2;
end adder_arch;

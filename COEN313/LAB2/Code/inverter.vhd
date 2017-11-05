library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity inverter is
port(
	in1: in std_logic;
	out1: out std_logic
);

end inverter;

architecture inv_arch of inverter is
begin
	out1 <= not in1;
end inv_arch;

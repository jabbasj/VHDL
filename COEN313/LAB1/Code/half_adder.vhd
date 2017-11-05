library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
 port ( in1, in2 : in std_logic;
 carry, sum : out std_logic);
end half_adder;

architecture true_outputs of half_adder is
begin
 carry <= (in1 and in2);
 sum <= (in1 xor in2);
end true_outputs;
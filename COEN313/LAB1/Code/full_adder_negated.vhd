library ieee;
use ieee.std_logic_1164.all;

entity full_adder_negated is
 port(carry_in, input1, input2 : in std_logic;
 sum_out_neg, carry_out_neg : out std_logic);
end full_adder_negated;

architecture structural of full_adder_negated is
  
-- declare a half-adder component
component half_adder
 port ( in1, in2 : in std_logic;
 carry, sum : out std_logic);
end component;

-- declare internal signals used to "hook up" components
signal carry1, carry2 : std_logic;
signal sum_int : std_logic;
signal sum_out, carry_out : std_logic;

-- declare configuration specification
for ha1, ha2 : half_adder use entity WORK.half_adder(true_outputs);
begin
-- component instantiation
ha1: half_adder port map(in1 => input1, in2 => input2,
 carry => carry1, sum => sum_int);
ha2: half_adder port map(in1 => sum_int, in2 => carry_in,
 carry => carry2, sum => sum_out);
carry_out <= carry1 or carry2;

-- negate the internal sum and carry to the external port signals
-- since the XUP Virtex2 Pro demo board has active LOW LED outputs
-- DIP switch in UP position will produce a logic-?0? value.

carry_out_neg <= not carry_out;
sum_out_neg <= not sum_out;
end structural;
#inputs
add wave a
add wave b
add wave add_sub
add wave logic_func
add wave func
add wave carry_in_hack

#outputs
add wave result
add wave overflow
add wave zero

#set the clk signal to a value of 1 at a time equal to 0 time units
#after the current simulation time and this will be repeated at a time commencing at 2 time units
#after the current simulation time
#force CLK 0 0 -r 2

#set the clk signal to a value of 1 at a time equal to 1 units
#after the current simulation time and this will be
#repeated starting at 2 time units after the current simulation time.
#force CLK 1 1 -r 2

#func : 00 = lui, 01 = setless , 10 = arith , 11 = logic
#logic_func : 00 = AND, 01 = OR , 10 = XOR , 11 = NOR

#lui
force func 00
force a 00000000000000000000000000000000
force b 11000000000000000000000000000011
run 2

#lui
force func 00
force a 00000000000000000000000000000000
force b 11111111111111111111111111111111
run 2

#lui
force func 00
force a 00000000001111111100000000000000
force b 00000000000000000000000000000000
run 2





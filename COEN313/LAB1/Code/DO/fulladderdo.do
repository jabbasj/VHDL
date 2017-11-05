add wave input1
add wave input2
add wave carry_in
add wave sum_out_neg
add wave carry_out_neg

force input1 0
force input2 0
force carry_in 0
run 2

force input1 0
force input2 0
force carry_in 1
run 2

force input1 1
force input2 1
force carry_in 1
run 2
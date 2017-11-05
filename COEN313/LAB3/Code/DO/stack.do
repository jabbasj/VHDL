#inputs
add wave DATA_IN
add wave RESET
add wave CLK
add wave WRITE
add wave READ_A
add wave READ_B
add wave WRITE_ADDRESS
add wave PUSH
add wave POP
add wave SAVE
add wave RESTORE
add wave push_counter
add wave shadow_push_counter
add wave registers
add wave shadow_registers

#outputs
add wave TOP_OUT
add wave FULL_OUT
add wave EMPTY_OUT
add wave OUT_A
add wave OUT_B

#set the clk signal to a value of 1 at a time equal to 0 time units
#after the current simulation time and this will be repeated at a time commencing at 2 time units
#after the current simulation time
#force CLK 0 0 -r 2

#set the clk signal to a value of 1 at a time equal to 1 units
#after the current simulation time and this will be
#repeated starting at 2 time units after the current simulation time.
#force CLK 1 1 -r 2

force PUSH 1
force POP 1
do clk.do

#pop while empty
force PUSH 1
force POP 0
do clk.do
force POP 1

#push 0001
force DATA_IN 0001
force PUSH 0
force POP 1
do clk.do
force PUSH 1

#push 0002
force DATA_IN 0010
force PUSH 0
force POP 1
do clk.do
force PUSH 1

#pop twice, should empty stack
force POP 0
force PUSH 1
do clk.do
force POP 1

force POP 0
force PUSH 1
do clk.do
force POP 1

#pop while empty
force POP 0
force PUSH 1
do clk.do
force POP 1


#push 0110
force PUSH 0
force POP 1
force DATA_IN 0110
do clk.do
force PUSH 1

#push 1111 3 times
force PUSH 0
force POP 1
force DATA_IN 1111
do clk.do
do clk.do
do clk.do
force PUSH 1

#read bottom of stack (0110) at index 11 (R3) on both out_a and out_b
force READ_A 11
force READ_B 11
do clk.do

#try to push 1010  on a full stack
force PUSH 0
force DATA_IN 1010
do clk.do
force PUSH 1

#try to push 0000 on a full stack
force PUSH 0
force DATA_IN 0000
do clk.do
force PUSH 1


#try save, will clear stack and copy it to shadow registers
force SAVE 0
do clk.do
force SAVE 1

#push 0000 in stack 4 times
force PUSH 0
force POP 1
force DATA_IN 0000
do clk.do
do clk.do
do clk.do
do clk.do
force PUSH 1

#try restore, old values should re-appear
force RESTORE 0
do clk.do
force RESTORE 1


#try write at R0
force DATA_IN 0000
force WRITE 0
force WRITE_ADDRESS 00
do clk.do
force WRITE 1

#try write at R1
force DATA_IN 0001
force WRITE 0
force WRITE_ADDRESS 01
do clk.do
force WRITE 1

#try write at R2
force DATA_IN 0010
force WRITE 0
force WRITE_ADDRESS 10
do clk.do
force WRITE 1

#try write at R3
force DATA_IN 0011
force WRITE 0
force WRITE_ADDRESS 11
do clk.do
force WRITE 1

#try reset
force RESET 0
do clk.do
force RESET 1


#try CLK for no reason
do clk.do
do clk.do
do clk.do







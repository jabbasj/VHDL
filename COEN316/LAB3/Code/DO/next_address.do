# do file to test the  next_address

add wave rs
add wave rt
add wave pc
add wave target_address
add wave branch_type
add wave pc_sel
add wave next_pc

#jump there ; jump to memory location “there”
#jr rs ; jump to memory location whose address is in rs
#beq rs,rt, loop ; jump to memory location “loop” if rs=rt
#bne rs,rt, loop ; jump to memory location ”loop” if rs /= rt
#bltz rs, loop ; jump to memory location “loop” if rs < 0

#JUMPS

#test no jump, no branch
#start from 00000000
#pc_next should be x"00000001"
force pc x"00000000" 
force pc_sel "00"
force branch_type "00"
run 2

#test jump there
#pc_next should be x"00000001"
#start from 00000000
#offet is 1
force pc x"00000000" 
force target_address "00000000000000000000000001"  
force pc_sel "01"
run 2


#test jr rs
#pc_next should be x"00000002"
#start from 00000000
#rs holds 2
force pc x"00000000" 
force rs x"00000002" 
force pc_sel "10"
run 2

#BRANCHING

#test beq rs,rt, loop with rs = rt
#pc_next should be x"00000004"
#start from 00000000
#rs holds 1
#rt holds 1

force pc x"00000000" 
force rs x"00000001" 
force rt x"00000001" 
force target_address "00000000000000000000000011"
force pc_sel "00"
force branch_type "01"
run 2

#test beq rs,rt, loop with rs = rt
#pc_next should be x"00000001"
#start from 00000001
#rs holds 1
#rt holds 1
force pc x"00000001" 
force rs x"00000001" 
force rt x"00000001" 
force target_address "00000000001111111111111111"
force pc_sel "00"
force branch_type "01"
run 2

#test beq rs,rt, loop with rs /= rt
#pc_next should be x"00000001"
#start from 00000000
#rs holds 1
#rt holds 3
force pc x"00000000" 
force rs x"00000001" 
force rt x"00000003" 
force target_address "00000000000000000000000001"
force pc_sel "00"
force branch_type "01"
run 2

#test bne rs,rt, loop with rs = rt
#pc should not change use offset, increment by 1
#start from 00000000
#rs holds 1
#rt holds 1
force pc x"00000000" 
force rs x"00000001" 
force rt x"00000001" 
force target_address "00000000000000000000000111"
force pc_sel "00"
force branch_type "10"
run 2

#test bne rs,rt, loop with rs /= rt
#pc_next should be x"00000003"
#start from 00000000
#rs holds 1
#rt holds 3
#target is 2
force pc x"00000000" 
force rs x"00000001"
force rt x"00000003" 
force target_address "00000000000000000000000010"
force pc_sel "00"
force branch_type "10"
run 2


#test bltz rs, loop with rs > 0
#pc_next should be x"00000001"
#start from 00000000
#rs holds 1
#target is 6
force pc x"00000000" 
force rs x"00000001" 
force target_address "00000000000000000000000110"
force pc_sel "00"
force branch_type "11"
run 2

#test bltz rs, loop with rs < 0
#pc_next should be x"00000003"
#start from 00000000
#rs holds F0000000
#target is 2
force pc x"00000000" 
force rs x"F0000000" 
force target_address "00000000000000000000000010"
force pc_sel "00"
force branch_type "11"
run 2


























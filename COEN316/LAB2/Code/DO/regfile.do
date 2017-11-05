# do file to test the  regfile

add wave reset
add wave clk
add wave data_in
add wave write
add wave read_a
add wave read_b 
add wave write_address
add wave out_a
add wave out_b
add wave registers

# reset
force  reset 0
force clk 0
force data_in X"FAFA3B3B"
force  write 1
force   write_address "00001"
force read_a "00000"
force read_b "00001"
run 2


#  deassert reset and write into R1

force reset 1
run 2
force write 0
run 2
force clk 1
run 2
force clk 0
run 2


# write X"FAFA3B3B" into R31 and sent R31 to both out ports
force write_address "11110"
run 2
force read_a "11110"
force read_b "11110"
force clk 1
run 2
force clk 0
run 2


# deassert write, and try to write new data into R31, shouild be no change
force write 1
run 2
force clk 1
run 2
force clk 0
run 2


# write data into R1-R31 consecutively
force write 0
force write_address "00001"
force data_in X"00000001"
force clk 1
run 2
force clk 0
run 2

force write_address "00010"
force data_in X"00000002"
force clk 1
run 2
force clk 0
run 2

force write_address "00011"
force data_in X"00000003"
force clk 1
run 2
force clk 0
run 2

force write_address "00100"
force data_in X"00000004"
force clk 1
run 2
force clk 0
run 2

force write_address "00101"
force data_in X"00000005"
force clk 1
run 2
force clk 0
run 2

force write_address "00110"
force data_in X"00000006"
force clk 1
run 2
force clk 0
run 2

force write_address "00111"
force data_in X"00000007"
force clk 1
run 2
force clk 0
run 2


force write_address "01000"
force data_in X"00000008"
force clk 1
run 2
force clk 0
run 2


force write_address "01001"
force data_in X"00000009"
force clk 1
run 2
force clk 0
run 2

force write_address "01010"
force data_in X"0000000A"
force clk 1
run 2
force clk 0
run 2

force write_address "01011"
force data_in X"0000000B"
force clk 1
run 2
force clk 0
run 2

force write_address "01100"
force data_in X"0000000C"
force clk 1
run 2
force clk 0
run 2

force write_address "01101"
force data_in X"0000000D"
force clk 1
run 2
force clk 0
run 2

force write_address "01110"
force data_in X"0000000E"
force clk 1
run 2
force clk 0
run 2

force write_address "01111"
force data_in X"0000000F"
force clk 1
run 2
force clk 0
run 2



# second hald of registers

force write_address "10000"
force data_in X"00000010"
force clk 1
run 2
force clk 0
run 2



force write_address "10001"
force data_in X"00000011"
force clk 1
run 2
force clk 0
run 2

force write_address "10010"
force data_in X"00000012"
force clk 1
run 2
force clk 0
run 2

force write_address "10011"
force data_in X"00000013"
force clk 1
run 2
force clk 0
run 2

force write_address "10100"
force data_in X"00000014"
force clk 1
run 2
force clk 0
run 2

force write_address "10101"
force data_in X"00000015"
force clk 1
run 2
force clk 0
run 2

force write_address "10110"
force data_in X"00000016"
force clk 1
run 2
force clk 0
run 2

force write_address "10111"
force data_in X"00000017"
force clk 1
run 2
force clk 0
run 2



force write_address "11000"
force data_in X"00000018"
force clk 1
run 2
force clk 0
run 2


force write_address "11001"
force data_in X"00000019"
force clk 1
run 2
force clk 0
run 2

force write_address "11010"
force data_in X"0000001A"
force clk 1
run 2
force clk 0
run 2

force write_address "11011"
force data_in X"0000001B"
force clk 1
run 2
force clk 0
run 2

force write_address "11100"
force data_in X"0000001C"
force clk 1
run 2
force clk 0
run 2

force write_address "11101"
force data_in X"0000001D"
force clk 1
run 2
force clk 0
run 2

force write_address "11110"
force data_in X"0000001E"
force clk 1
run 2
force clk 0
run 2


force write_address "11111"
force data_in X"0000001F"
force clk 1
run 2
force clk 0
run 2


# now deassert the write and read out consecutively asynchronously

force write 1
force read_a "00000"
force read_b "00001"
run 2

force read_a "00001"
force read_b "00010"
run 2

force read_a "00011"
force read_b "00100"
run 2

force read_a "00100"
force read_b "00101"
run 2

force read_a "00110"
force read_b "00111"
run 2

force read_a "00111"
force read_b "01000"
run 2


# next quarter 


force read_a "01001"
force read_b "01010"
run 2

force read_a "01011"
force read_b "01100"
run 2

force read_a "01101"
force read_b "01110"
run 2

force read_a "01111"
force read_b "10000"
run 2




# second half of reads


force read_a "10001"
force read_b "10010"
run 2

force read_a "10011"
force read_b "10100"
run 2

force read_a "10101"
force read_b "10110"
run 2

force read_a "10111"
force read_b "11000"
run 2

force read_a "11001"
force read_b "11010"
run 2

force read_a "11011"
force read_b "11100"
run 2


# next 3 quarter 


force read_a "11101"
force read_b "11110"
run 2

force read_a "11111"
force read_b "11111"
run 2


























add wave din
add wave clk
add wave load
add wave inc
add wave q

force din "0010"
force load 1

force clk 0
run 2

force clk 1
run 2

force load 0
run 2

force clk 0
run 2

force clk 1
run 2

force inc 1
run 2

force clk 0
run 2

force clk 1
run 2

force load 1
force clk 0
run 2

force clk 1
run 2

vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr -mfcu  \
"../../../mips_tp3.srcs/sources_1/new/program_counter.v" \
"../../../mips_tp3.srcs/sources_1/new/xilinx_one_port_ram_async.v" \
"../../../mips_tp3.srcs/sources_1/new/instruction_fetch.v" \


vlog -work xil_defaultlib \
"glbl.v"


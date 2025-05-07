vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr -mfcu  \
"../../../mips_tp3.srcs/sources_1/new/program_counter.v" \
"../../../mips_tp3.srcs/sources_1/new/xilinx_one_port_ram_async.v" \
"../../../mips_tp3.srcs/sources_1/new/instruction_fetch.v" \


vlog -work xil_defaultlib \
"glbl.v"


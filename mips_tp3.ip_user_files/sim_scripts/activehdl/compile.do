transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 -l xil_defaultlib \
"../../../mips_tp3.srcs/sources_1/new/program_counter.v" \
"../../../mips_tp3.srcs/sources_1/new/xilinx_one_port_ram_async.v" \
"../../../mips_tp3.srcs/sources_1/new/instruction_fetch.v" \


vlog -work xil_defaultlib \
"glbl.v"


transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+instruction_fetch  -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.instruction_fetch xil_defaultlib.glbl

do {instruction_fetch.udo}

run 1000ns

endsim

quit -force

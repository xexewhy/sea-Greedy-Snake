onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib snake_R_opt

do {wave.do}

view wave
view structure
view signals

do {snake_R.udo}

run -all

quit -force

onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib apple_G_opt

do {wave.do}

view wave
view structure
view signals

do {apple_G.udo}

run -all

quit -force

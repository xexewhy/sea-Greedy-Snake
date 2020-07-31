onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib body_G_opt

do {wave.do}

view wave
view structure
view signals

do {body_G.udo}

run -all

quit -force

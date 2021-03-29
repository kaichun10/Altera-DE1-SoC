transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/LocalAltera/LocalQuartusProjects/DE1-SoC/OutputVGA/VGA.vhd}


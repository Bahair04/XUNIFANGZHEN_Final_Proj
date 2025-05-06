transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/XUNIFANGZHEN/FPGA/rtl {D:/XUNIFANGZHEN/FPGA/rtl/FPGA.v}
vlog -vlog01compat -work work +incdir+D:/XUNIFANGZHEN/FPGA/rtl {D:/XUNIFANGZHEN/FPGA/rtl/vga_pic.v}
vlog -vlog01compat -work work +incdir+D:/XUNIFANGZHEN/FPGA/rtl {D:/XUNIFANGZHEN/FPGA/rtl/vga_ctrl.v}
vlog -vlog01compat -work work +incdir+D:/XUNIFANGZHEN/FPGA/rtl {D:/XUNIFANGZHEN/FPGA/rtl/sobel.v}
vlog -vlog01compat -work work +incdir+D:/XUNIFANGZHEN/FPGA/prj {D:/XUNIFANGZHEN/FPGA/prj/ram1.v}
vlog -vlog01compat -work work +incdir+D:/XUNIFANGZHEN/FPGA/prj {D:/XUNIFANGZHEN/FPGA/prj/altpll1.v}
vlog -vlog01compat -work work +incdir+D:/XUNIFANGZHEN/FPGA/prj {D:/XUNIFANGZHEN/FPGA/prj/rom1.v}
vlog -vlog01compat -work work +incdir+D:/XUNIFANGZHEN/FPGA/prj {D:/XUNIFANGZHEN/FPGA/prj/shiftreg.v}
vlog -vlog01compat -work work +incdir+D:/XUNIFANGZHEN/FPGA/prj/db {D:/XUNIFANGZHEN/FPGA/prj/db/altpll1_altpll.v}

vlog -vlog01compat -work work +incdir+D:/XUNIFANGZHEN/FPGA/prj/../sim {D:/XUNIFANGZHEN/FPGA/prj/../sim/tb_vga_pic.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb_vga_pic

add wave *
view structure
view signals
run -all

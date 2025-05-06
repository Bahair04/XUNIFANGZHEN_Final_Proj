library verilog;
use verilog.vl_types.all;
entity tb_vga_pic is
    generic(
        PERIOD          : integer := 20;
        SIMU_TIME       : vl_notype
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of PERIOD : constant is 1;
    attribute mti_svvh_generic_type of SIMU_TIME : constant is 3;
end tb_vga_pic;

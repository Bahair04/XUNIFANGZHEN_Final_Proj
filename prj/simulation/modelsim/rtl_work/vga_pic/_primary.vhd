library verilog;
use verilog.vl_types.all;
entity vga_pic is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        keyin           : in     vl_logic_vector(3 downto 0);
        pix_x           : in     vl_logic_vector(9 downto 0);
        pix_y           : in     vl_logic_vector(9 downto 0);
        color_data_out  : out    vl_logic_vector(23 downto 0)
    );
end vga_pic;

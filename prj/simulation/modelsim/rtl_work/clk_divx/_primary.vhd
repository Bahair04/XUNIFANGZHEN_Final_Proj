library verilog;
use verilog.vl_types.all;
entity clk_divx is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        div_fact        : in     vl_logic_vector(23 downto 0);
        clk_div         : out    vl_logic
    );
end clk_divx;

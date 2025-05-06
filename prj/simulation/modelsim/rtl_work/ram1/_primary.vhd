library verilog;
use verilog.vl_types.all;
entity ram1 is
    port(
        address         : in     vl_logic_vector(14 downto 0);
        clock           : in     vl_logic;
        data            : in     vl_logic_vector(0 downto 0);
        rden            : in     vl_logic;
        wren            : in     vl_logic;
        q               : out    vl_logic_vector(0 downto 0)
    );
end ram1;

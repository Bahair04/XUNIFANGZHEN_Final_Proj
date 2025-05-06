library verilog;
use verilog.vl_types.all;
entity altpll1 is
    port(
        areset          : in     vl_logic;
        inclk0          : in     vl_logic;
        c0              : out    vl_logic
    );
end altpll1;

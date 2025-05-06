library verilog;
use verilog.vl_types.all;
entity shiftreg is
    port(
        clken           : in     vl_logic;
        clock           : in     vl_logic;
        shiftin         : in     vl_logic_vector(7 downto 0);
        shiftout        : out    vl_logic_vector(7 downto 0);
        taps0x          : out    vl_logic_vector(7 downto 0);
        taps1x          : out    vl_logic_vector(7 downto 0)
    );
end shiftreg;

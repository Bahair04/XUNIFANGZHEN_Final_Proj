library verilog;
use verilog.vl_types.all;
entity sobel is
    generic(
        HOR_SCREEN      : integer := 800;
        VERT_SCREEN     : integer := 480;
        HOR_PIC         : integer := 160;
        VERT_PIC        : integer := 160
    );
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        data_in         : in     vl_logic_vector(7 downto 0);
        data_ready      : in     vl_logic;
        data_out        : out    vl_logic;
        data_valid      : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of HOR_SCREEN : constant is 1;
    attribute mti_svvh_generic_type of VERT_SCREEN : constant is 1;
    attribute mti_svvh_generic_type of HOR_PIC : constant is 1;
    attribute mti_svvh_generic_type of VERT_PIC : constant is 1;
end sobel;

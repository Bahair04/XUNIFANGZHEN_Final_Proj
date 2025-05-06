library verilog;
use verilog.vl_types.all;
entity vga_ctrl is
    generic(
        H_TOTAL         : integer := 1056;
        \HSYNC\         : integer := 0;
        HBP             : integer := 46;
        HLB             : integer := 0;
        HDISP           : integer := 800;
        HRB             : integer := 0;
        HFP             : integer := 210;
        V_TOTAL         : integer := 525;
        \VSYNC\         : integer := 0;
        VBP             : integer := 22;
        VTB             : integer := 0;
        VDISP           : integer := 480;
        VBB             : integer := 0;
        VFP             : integer := 23
    );
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        pix_data        : in     vl_logic_vector(23 downto 0);
        valid           : out    vl_logic;
        pix_x           : out    vl_logic_vector(9 downto 0);
        pix_y           : out    vl_logic_vector(9 downto 0);
        hsync           : out    vl_logic;
        vsync           : out    vl_logic;
        rgb             : out    vl_logic_vector(23 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of H_TOTAL : constant is 1;
    attribute mti_svvh_generic_type of \HSYNC\ : constant is 1;
    attribute mti_svvh_generic_type of HBP : constant is 1;
    attribute mti_svvh_generic_type of HLB : constant is 1;
    attribute mti_svvh_generic_type of HDISP : constant is 1;
    attribute mti_svvh_generic_type of HRB : constant is 1;
    attribute mti_svvh_generic_type of HFP : constant is 1;
    attribute mti_svvh_generic_type of V_TOTAL : constant is 1;
    attribute mti_svvh_generic_type of \VSYNC\ : constant is 1;
    attribute mti_svvh_generic_type of VBP : constant is 1;
    attribute mti_svvh_generic_type of VTB : constant is 1;
    attribute mti_svvh_generic_type of VDISP : constant is 1;
    attribute mti_svvh_generic_type of VBB : constant is 1;
    attribute mti_svvh_generic_type of VFP : constant is 1;
end vga_ctrl;

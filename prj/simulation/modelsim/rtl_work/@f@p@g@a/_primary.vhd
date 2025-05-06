library verilog;
use verilog.vl_types.all;
entity FPGA is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        keyin           : in     vl_logic_vector(3 downto 0);
        LCD_HS          : out    vl_logic;
        LCD_VS          : out    vl_logic;
        LCD_PCLK        : out    vl_logic;
        LCD_RST         : out    vl_logic;
        LCD_BL          : out    vl_logic;
        LCD_DE          : out    vl_logic;
        R               : out    vl_logic_vector(7 downto 0);
        G               : out    vl_logic_vector(7 downto 0);
        B               : out    vl_logic_vector(7 downto 0)
    );
end FPGA;

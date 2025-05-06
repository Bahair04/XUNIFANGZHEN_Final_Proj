module FPGA (
    input  wire clk,
    input  wire rst,
    input  wire [3 : 0] keyin, 
    output wire LCD_HS,
    output wire LCD_VS,
    output wire LCD_PCLK,
    output wire LCD_RST,
    output wire LCD_BL,
    output wire LCD_DE,
    output wire [7 : 0] R,
    output wire [7 : 0] G,
    output wire [7 : 0] B       
      
);
assign rstn = ~rst;
wire c0;
wire [9 : 0] pix_x;
wire [9 : 0] pix_y;
wire [23 : 0] rgb;
wire [23 : 0] pix_data;

/*========================VGA LCD��ʾģ��========================*/
altpll1 altpll1_inst                                 //����ʱ���ź�    
(
    .inclk0(clk),
    .areset(rst),
    .c0(c0)
);
vga_pic vga_pic                                 //ͼ�����ݿ���ģ��
(
    .rstn(rstn),
    .clk(c0),
    .keyin(keyin),
    .pix_y(pix_y),
    .pix_x(pix_x),
    .color_data_out(pix_data)
);
wire hsync;
wire vsync; 
vga_ctrl vga_ctrl                               //VGA LCD����ģ��
(
    .clk(c0),
    .rstn(rstn),
    .pix_data(pix_data),
    .pix_x(pix_x),
    .pix_y(pix_y),
    .hsync(hsync),
    .vsync(vsync),
    .rgb(rgb),
    .valid(LCD_DE)
);
assign R = rgb[23:16];
assign G = rgb[15:8];
assign B = rgb[7:0];
assign LCD_BL = 1'b1;
assign LCD_RST = 1'b1;
assign LCD_PCLK = c0;
assign LCD_HS = 1'b1;
assign LCD_VS = 1'b1;
endmodule
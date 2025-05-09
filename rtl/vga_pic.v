module vga_pic (
    output wire tb_ram_rden,
    output wire [23 : 0] tb_color_data_out,
    output wire tb_rom_en,
    input wire clk,                                 //时钟信号
    input wire rstn,                                //复位信号(低电平有效)
    input wire [3 : 0] keyin,                       //按键输入
    input wire [9 : 0] pix_x,                       //当前像素横坐标
    input wire [9 : 0] pix_y,                       //当前像素纵坐标
    output reg [23 : 0] color_data_out              //颜色数据
);

localparam HOR_SCREEN = 'd800;                      //屏幕宽度
localparam VERT_SCREEN = 'd480;                     //屏幕高度
localparam HOR_PIC = 'd160;
localparam VERT_PIC = 'd160;
localparam PIC_START_X = 'd500; // 列
localparam PIC_START_Y = 'd200; // 行
reg rom_en;
reg ram_rden;
wire ram_data;
always @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0) begin
        rom_en <= 1'b0;
        ram_rden <= 1'b0;
    end
    else if (keyin == 4'b0001 || keyin == 4'b0010) begin
        if (pix_x >= PIC_START_X && pix_x <= PIC_START_X + HOR_PIC - 1 && pix_y >= PIC_START_Y && pix_y <= PIC_START_Y + VERT_PIC - 1)
            rom_en <= 1'b1;
        else
            rom_en <= 1'b0;
    end
    else if (keyin == 4'b0100) begin
        if (pix_x >= PIC_START_X && pix_x <= PIC_START_X + HOR_PIC - 1 - 2 && pix_y >= PIC_START_Y && pix_y <= PIC_START_Y + VERT_PIC - 1 - 2)
            ram_rden <= 1'b1;
        else
            ram_rden <= 1'b0;
    end    
end
reg [15 : 0] rom_addr;
reg [15 : 0] ram_addr;
wire data_valid;
always @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0) begin
        rom_addr <= 16'd0;
        ram_addr <= 16'd0;
    end
    else if (keyin == 4'b0001 || keyin == 4'b0010) begin
        if (rom_en == 1'b1)
            rom_addr <= rom_addr + 1'b1;
        else if (pix_x == PIC_START_X + HOR_PIC && pix_y == PIC_START_Y + VERT_PIC )
            rom_addr <= 16'd0;
        if (data_valid == 1'b1 && ram_addr == (HOR_PIC - 2) * (VERT_PIC - 2) - 1)
            ram_addr <= 16'b0;
        else if (data_valid == 1'b1)
            ram_addr <= ram_addr + 1'b1;
    end
    else if (keyin == 4'b0100) begin
        if (ram_rden == 1'b1 && ram_addr == (HOR_PIC - 2) * (VERT_PIC - 2) - 1)
            ram_addr <= 16'b0;
        else if (ram_rden == 1'b1)
            ram_addr <= ram_addr + 1'b1;
    end
    else if (keyin == 4'b0000) begin
        rom_addr <= 16'd0;
        ram_addr <= 16'd0;
    end
end
wire [23 : 0] color_data;
rom1 rom1_inst (
	.address ( rom_addr ),
	.clock ( clk ),
	.q ( color_data ),
    .rden( rom_en )
);
reg [7 : 0] gray_data;
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        gray_data <= 8'h00;
    end
    else begin
        gray_data <= {(color_data[23 : 16] * 77 + color_data[15 : 8] * 150 + color_data[7 : 0] * 29) >> 8};
    end
end
wire data_out;
sobel #(
    .HOR_SCREEN  	(800  ),
    .VERT_SCREEN 	(480  ),
    .HOR_PIC     	(160  ),
    .VERT_PIC    	(160  ))
u_sobel(
    .clk        	(clk         ),
    .rstn       	(rstn        ),
    .data_in    	(gray_data   ),
    .data_ready 	(rom_en      ),
    .data_out   	(data_out    ),
    .data_valid 	(data_valid  )
);

ram1 ram1_inst (
	.address ( ram_addr ),
	.clock ( clk ),
	.data ( data_out ),
	.rden ( ram_rden ),
	.wren ( data_valid ),
	.q ( ram_data )
);
always @(*) begin
    if (rom_en == 1'b0 && ram_rden == 1'b0)
        color_data_out <= 24'hFFFFFF;
    else if (keyin == 4'b0001)
        color_data_out <= color_data;
    else if (keyin == 4'b0010)
        color_data_out <= {gray_data, gray_data, gray_data};
    else if (keyin == 4'b0100)
        color_data_out <= ram_data ? 24'hFFFFFF : 24'h000000;
end

assign tb_ram_rden = ram_rden;
assign tb_color_data_out = color_data_out;
assign tb_rom_en = rom_en;
endmodule
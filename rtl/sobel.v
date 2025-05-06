module sobel
#
(
    parameter HOR_SCREEN = 'd800,
    parameter VERT_SCREEN = 'd480,
    parameter HOR_PIC = 'd160,
    parameter VERT_PIC = 'd160
)
(
    input wire clk,
    input wire rstn,
    input wire [7 : 0] data_in,
    input wire data_ready,
    output wire data_out,
    output wire data_valid
);
reg [7 : 0] cnt_col;
reg [7 : 0] cnt_row;
always @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0) begin
        cnt_col <= 8'd0;
        cnt_row <= 8'd0;
    end
    else if (data_ready) begin
        if (cnt_col == HOR_PIC - 1 && cnt_row == VERT_PIC - 1) begin
            cnt_col <= 8'd0;
            cnt_row <= 8'd0;
        end
        else if (cnt_col == HOR_PIC - 1) begin
            cnt_col <= 8'd0;
            cnt_row <= cnt_row + 1'b1;
        end
        else
            cnt_col <= cnt_col + 1'b1;
    end
end

wire [7 : 0] row_former;
wire [7 : 0] row_later;
wire [7 : 0] row_last = data_in;
shiftreg	shiftreg_inst (
	.clken ( data_ready ),
	.clock ( clk ),
	.shiftin ( row_last ),
	.taps0x ( row_later ),
	.taps1x ( row_former )
);

reg [7 : 0] reg11, reg12, reg13;
reg [7 : 0] reg21, reg22, reg23;
reg [7 : 0] reg31, reg32, reg33;
integer i = 0;
always @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0) begin
        reg11 <= 8'h00;reg12 <= 8'h00;reg13 <= 8'h00;
        reg21 <= 8'h00;reg22 <= 8'h00;reg23 <= 8'h00;
        reg31 <= 8'h00;reg32 <= 8'h00;reg33 <= 8'h00;
    end
    else if (data_ready) begin
        {reg11, reg12, reg13} <= {reg12, reg13, row_former};
        {reg21, reg22, reg23} <= {reg22, reg23, row_later};
        {reg31, reg32, reg33} <= {reg32, reg33, row_last};
    end
end
reg [9 : 0] Gx1, Gy1;
reg [9 : 0] Gx3, Gy3;
always @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0) begin
        Gx1 <= 10'd0;Gy1 <= 10'd0;
        Gx3 <= 10'd0;Gy3 <= 10'd0;
    end
    else begin
        Gx1 <= reg11 + (reg21 << 1) + reg31;
        Gx3 <= reg13 + (reg23 << 1) + reg33;
        Gy1 <= reg11 + (reg12 << 1) + reg13;
        Gy3 <= reg31 + (reg32 << 1) + reg33;
    end
end
reg [9 : 0] Gx, Gy;
always @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0) begin
        Gx <= 0;
        Gy <= 0;
    end
    else begin
        Gx <= (Gx1 > Gx3) ? Gx1 - Gx3 : Gx3 - Gx1;
        Gy <= (Gy1 > Gy3) ? Gy1 - Gy3 : Gy3 - Gy1;
    end
end
reg [7 : 0] G;
always @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0)
        G <= 8'b0;
    else begin
        G <= Gx + Gy;
    end
end
assign data_out = G > 230 ? 1 : 0;
reg data_valid_reg;
always @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0)
        data_valid_reg <= 1'b0;
    else if (cnt_col <= 1 || cnt_row <= 1)
        data_valid_reg <= 1'b0;
    else if (cnt_col <= HOR_PIC - 1 && cnt_row <= VERT_PIC - 1)
        data_valid_reg <= 1'b1;
    else
        data_valid_reg <= 1'b0;
end
assign data_valid = data_valid_reg;
endmodule
module vga_ctrl 
#
(
    parameter H_TOTAL = 'd1056,         //Hor Total Time
    parameter HSYNC = 'd0,            //Hor Sync Time
    parameter HBP = 'd46,              //Hor Back Porch
    parameter HLB = 'd0,               //Hor Left Border
    parameter HDISP = 'd800,           //Hor Addr Time      
    parameter HRB = 'd0,               //Hor Right Boder
    parameter HFP = 'd210,               //Hor Front Porch
   
    
    parameter V_TOTAL = 'd525,          //Ver Total Time
    parameter VSYNC = 'd0,              //Ver Sync Time
    parameter VBP = 'd22,               //Ver Back Porch
    parameter VTB = 'd0,                //Ver Top Border    
    parameter VDISP = 'd480,            //Ver Addr Time                 
    parameter VBB = 'd0,                //Ver Bottom Boder
    parameter VFP = 'd23                 //Ver Front Porch
    
)
(
    input wire clk,
    input wire rstn,
    input wire [23 : 0] pix_data,
    output wire valid,  
    output wire [9 : 0] pix_x,
    output wire [9 : 0] pix_y,
    output reg hsync,
    output reg vsync,
    output wire [23 : 0] rgb
);

reg [10 : 0] cnth;
reg [10 : 0] cntv;
reg rgb_valid;
reg pix_data_req;

always @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0)   
        cnth <= 1'b0;
    else if (cnth == H_TOTAL - 1)
        cnth <= 1'b0;
    else
        cnth <= cnth + 1'b1;
end

always @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0)
        cntv <= 1'b0;
    else if (cntv == V_TOTAL - 1 && cnth == H_TOTAL - 1)
        cntv <= 1'b0;
    else if (cnth == H_TOTAL - 1)
        cntv <= cntv + 1'b1;
end

always @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0)
        hsync <= 1'b0;
    else if (cnth >= 0 && cnth < HSYNC)
        hsync <= 1'b1;
    else
        hsync <= 1'b0;
end

always @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0)
        vsync <= 1'b0;
    else if (cntv >= 0 && cntv < VSYNC)
        vsync <= 1'b1;
    else
        vsync <= 1'b0;
end

always @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0)
        rgb_valid <= 1'b0;
    else if ((cnth >= HSYNC + HBP + HLB && cnth < HSYNC + HBP + HLB + HDISP) && (cntv >= VSYNC + VBP + VTB && cntv < VSYNC + VBP + VTB + VDISP))
        rgb_valid <= 1'b1;
    else
        rgb_valid <= 1'b0;
end

always @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0)
        pix_data_req <= 1'b0;
    else if ((cnth >= HSYNC + HBP + HLB - 1 && cnth < HSYNC + HBP + HLB + HDISP - 1) && (cntv >= VSYNC + VBP + VTB - 1 && cntv < VSYNC + VBP + VTB + VDISP - 1))
        pix_data_req <= 1'b1;
    else
        pix_data_req <= 1'b0;
end

assign pix_x = (pix_data_req == 1'b1) ? (cnth - HSYNC - HBP - HLB + 1'b1) : 10'h3ff;
assign pix_y = (pix_data_req == 1'b1) ? (cntv - VSYNC - VBP - VTB + 1'b1) : 10'h3ff;
assign rgb = (rgb_valid == 1'b1) ? pix_data : 12'h0;
assign valid = rgb_valid;
endmodule
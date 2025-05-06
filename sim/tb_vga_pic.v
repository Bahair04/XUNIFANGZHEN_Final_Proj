//~ `New testbench
`timescale  1ns / 1ps

module tb_vga_pic;

// vga_pic Parameters
parameter PERIOD  = 20;
parameter SIMU_TIME = PERIOD * 800 * 480 * 2;

// vga_pic Inputs
reg   clk                                  = 0 ;
reg   rstn                                 = 0 ;
reg   [3 : 0]  keyin                       = 0 ;
reg   [9 : 0]  pix_x                       = 0 ;
reg   [9 : 0]  pix_y                       = 0 ;

// vga_pic Outputs
wire  [23 : 0]  color_data_out             ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

initial begin
    keyin <= 4'b0001;
    #(SIMU_TIME / 2) keyin <= 4'b0100;
end

always @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0)
        pix_x <= 0;
    else if (pix_x == 800 - 1)
        pix_x <= 0;
    else 
        pix_x <= pix_x + 1'b1;
end

always @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0)
        pix_y <= 0;
    else if (pix_y == 480 - 1 && pix_x == 800 - 1)
        pix_y <= 0;
    else if (pix_x == 800 - 1)
        pix_y <= pix_y + 1'b1;
end

vga_pic  u_vga_pic (
    .clk                     ( clk                      ),
    .rstn                    ( rstn                     ),
    .keyin                   ( keyin           [3 : 0]  ),
    .pix_x                   ( pix_x           [9 : 0]  ),
    .pix_y                   ( pix_y           [9 : 0]  ),

    .color_data_out          ( color_data_out  [23 : 0] )
);

initial
begin
    #(SIMU_TIME) $finish;
end

endmodule
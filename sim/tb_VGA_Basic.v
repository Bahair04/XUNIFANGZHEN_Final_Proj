`timescale  1ns / 1ps

module tb_VGA_Basic;

// VGA_Basic Parameters
parameter PERIOD  = 20;
parameter SIMU_TIME = PERIOD * 1056 * 4;

// VGA_Basic Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 1 ;
reg   [3 : 0]  keyin                       = 0 ;

// VGA_Basic Outputs
wire  LCD_HS                               ;
wire  LCD_VS                               ;
wire  LCD_PCLK                             ;
wire  LCD_RST                              ;
wire  LCD_BL                               ;
wire  LCD_DE                               ;
wire  [7 : 0]  R                           ;
wire  [7 : 0]  G                           ;
wire  [7 : 0]  B                           ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst  =  0;
end

VGA_Basic  u_VGA_Basic (
    .clk                     ( clk               ),
    .rst                     ( rst               ),
    .keyin                   ( keyin     [3 : 0] ),

    .LCD_HS                  ( LCD_HS            ),
    .LCD_VS                  ( LCD_VS            ),
    .LCD_PCLK                ( LCD_PCLK          ),
    .LCD_RST                 ( LCD_RST           ),
    .LCD_BL                  ( LCD_BL            ),
    .LCD_DE                  ( LCD_DE            ),
    .R                       ( R         [7 : 0] ),
    .G                       ( G         [7 : 0] ),
    .B                       ( B         [7 : 0] )
);

initial
begin
    #(SIMU_TIME) $finish;
end

endmodule
/* 任意时钟分频器 */
module clk_divx
(
    input wire clk,
    input wire rstn,
    input wire [23 : 0] div_fact,
    output wire clk_div
);
reg [23 : 0] cnt;
always @(posedge clk or negedge rstn) begin
    if (!rstn)
        cnt <= 24'b0;
    else if (cnt == div_fact - 1)
        cnt <= 24'b0;
    else 
        cnt <= cnt + 1;
end
reg clk_div_reg;
always @(posedge clk or negedge rstn) begin
    if (!rstn)
        clk_div_reg <= 1'b0;
    else if (cnt == div_fact - 2)
        clk_div_reg <= 1'b1;
    else 
        clk_div_reg <= 1'b0;
end
assign clk_div = (div_fact == 24'b1) ? clk : clk_div_reg; // 如果分频系数为1，则输出即为输入，否则为分频后的时钟
endmodule
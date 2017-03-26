`timescale 1ns / 1ps
module Precomp_TB();
reg [3:0]in;
reg clk,reset;
wire [15:0]out;
Filter_Precomp #(.n(4))p1(.out(out),.in(in),.clk(clk),.reset(reset));

initial
begin
reset=1'b1;
clk=1'b0;
end
always
#5 clk=~clk;
initial
begin
#5 reset=1'b0; in=4'd10;

#15 $display($time," out=%d ",out);
end
endmodule

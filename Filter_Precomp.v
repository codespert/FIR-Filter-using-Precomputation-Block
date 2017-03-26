module Filter_Precomp #(parameter n=4)(out,in,clk,reset);
output [(4*n):0]out;
input [n-1:0]in;
input clk,reset;
wire [(4*n):0]w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,w16;
wire [(4*n):0]p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,o0,o1,d;
wire [(4*n):0]w[9:0];
wire [(4*n):0]r[9:0];

Precompute_Main #(.n(4),.h0(30))m1(o0,w0,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11,w12,w13,w14,w15,in,clk,reset);
DFF #(.n(4))D1(w[0],o0,clk,reset);

genvar i;
generate
for(i=0;i<3;i=i+1)begin
FA #(.n(4))f2(w[i+1],w[i],o0,1'b0);
DFF #(.n(4))D2(r[i],w[i+1],clk,reset);
end
endgenerate
assign out=r[2];
endmodule

module Precompute_Main #(parameter n=4,h0=8'd30)(out,xn0,xn1,xn2,xn3,xn4,xn5,xn6,xn7,xn8,xn9,xn10,xn11,xn12,xn13,xn14,xn15,xn,clk,reset);
input [n-1:0]xn;
input clk,reset;
output [(4*n):0]out,xn0,xn1,xn2,xn3,xn4,xn5,xn6,xn7,xn8,xn9,xn10,xn11,xn12,xn13,xn14,xn15;
wire[(4*n):0]w1,w2;
assign xn0='d0;
assign xn1={4'd0,xn};
assign xn2=xn<<1;
FA #(.n(4))f1(xn3,xn<<1,xn1,1'b0);
assign xn4=xn<<2;
FA #(.n(4))f2(xn5,xn<<2,xn1,1'b0);
assign xn6=xn3<<1;
FS #(.n(4))f3(xn7,xn<<3,xn1,1'b0);
assign xn8=xn<<3;
FA #(.n(4))f4(xn9,xn<<3,xn1,1'b0);
assign xn10=xn5<<1;
FA #(.n(4))f5(xn11,xn<<3,xn3,1'b0);
assign xn12=xn3<<2;
FA #(.n(4))f6(xn13,xn<<3,xn5,1'b0);
assign xn14=xn7<<1;
FS #(.n(4))f7(xn15,xn<<4,xn1,1'b0);

MUX m1(w2,xn0,xn1,xn2,xn3,xn4,xn5,xn6,xn7,xn8,xn9,xn10,xn11,xn12,xn13,xn14,xn15,h0[7:4],clk);
MUX m2(w1,xn0,xn1,xn2,xn3,xn4,xn5,xn6,xn7,xn8,xn9,xn10,xn11,xn12,xn13,xn14,xn15,h0[3:0],clk);
FA #(.n(4))f8(out,w1,(w2<<4),1'b0);

endmodule


module DFF #(parameter n=4)(q,d,clk,reset);
output reg [(4*n):0]q;
input [(4*n):0]d;
input clk,reset;
always @ (posedge clk)
begin
if(reset==1)
begin
q<=0;
end
else
begin
q<=d;
end
end
endmodule

module FA #(parameter n=4)(sum,a,b,cin);
output [(4*n):0]sum;
input [(4*n)-1:0]a,b;
input cin;
wire c;
assign {c,sum}=a+b+cin;
endmodule


module FA #(parameter n=4)(sum,a,b,cin);
output [(4*n):0]sum;
input [(4*n)-1:0]a,b;
input cin;
wire c;
assign {c,sum}=a+b+cin;
endmodule

module FS #(parameter n=4)(sub,a,b,cin);
output [(4*n)-1:0]sub;
input [(4*n)-1:0]a,b;
input cin;
wire c;
assign {c,sub}=a-b-cin;
endmodule

module MUX(out,a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,s,clk);
output reg [15:0]out;
input [15:0]a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15;
input [3:0]s;
input clk;
always @ (posedge clk)
begin
case(s)
4'b0000: out=a0;
4'b0001: out=a1;
4'b0010: out=a2;
4'b0011: out=a3;
4'b0100: out=a4;
4'b0101: out=a5;
4'b0110: out=a6;
4'b0111: out=a7;
4'b1000: out=a8;
4'b1001: out=a9;
4'b1010: out=a10;
4'b1011: out=a11;
4'b1100: out=a12;
4'b1101: out=a13;
4'b1110: out=a14;
4'b1111: out=a15;
endcase
end
endmodule

module DFF #(parameter n=4)(q,d,clk,reset);
output reg [(4*n):0]q;
input [(4*n):0]d;
input clk,reset;
always @ (posedge clk)
begin
if(reset==1)
begin
q<=0;
end
else
begin
q<=d;
end
end
endmodule

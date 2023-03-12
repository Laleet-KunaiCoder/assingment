`timescale 1ns / 1ps
`include "nmultiplier.v"
//`include "moduler.v"
module karatsuba_multiplier #(parameter n=1)(
  input [n-1:0] A,
  input [n-1:0] B,
  output [n-1:0] C,
  output [2*n-1:0] OUT
);
  parameter s=n/2;
  wire [2*(n/2)-1:0] albl;
  nmultiplier #(n/2) km1(.a(A[n/2-1:0]), .b(B[n/2-1:0]), .out(albl));

  wire [2*(n-n/2)-1:0] ahbh;
  nmultiplier #(n-n/2) km2(.a(A[n-1:n/2]), .b(B[n-1:n/2]), .out(ahbh));

  wire [2*(n-n/2)-1:0] s_mid;
  nmultiplier #(n-n/2) km3(.a(A[n-1:n/2]^A[n/2-1:0]), .b(B[n-1:n/2]^B[n/2-1:0]), .out(s_mid));
  reg [2*n-1:0] result;
   always @(*) begin
      result=0;
      result=^(ahbh<<2*s)^albl^((s_mid^albl^ahbh)<<s);
    end
    assign OUT=result;
endmodule

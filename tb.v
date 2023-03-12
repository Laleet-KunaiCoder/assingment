`timescale 1ns / 1ps
`include "karatsuba_multiplier.v"
module tb( );
    parameter n = 163;
    reg [n-1:0]A,B;
    wire [n-1:0]C;
    wire [2*n-1:0] OUT;
    karatsuba_multiplier #(n) dut(.A(A),.B(B),.C(C),.OUT(OUT));
    initial 
    begin
    $dumpfile("tb.vcd");
    $dumpvars(0,tb);
        A = 55;
        B = 5;
        #100;
    end
endmodule

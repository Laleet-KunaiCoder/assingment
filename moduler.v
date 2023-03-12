`timescale 1ns/1ps 
module moduler #(
    parameter n=1,
    parameter overflow=0
) (
    output [n-1:0] C
);
if(overflow!=0){
    wire [overflow-1:0] Over;
}
    
endmodule
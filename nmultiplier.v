`timescale 1ns / 1ps
module nmultiplier #(parameter k=1)(
  input [k-1:0] a,
  input [k-1:0] b,
  output [2*k-1:0] out
);
  parameter s=k/2;
  reg [2*k-1:0] result;
  if(k==1)begin
    integer i;
    always @(*) begin
      result=0;
      for (i = 0; i < 1; i = i + 1) begin
        if (b[i] == 1) begin
          result = result ^ (a << i);
          end
        end
    end
  end
  // else if(k==10)begin
  //   integer i;
  //   always @(*) begin
  //     result=0;
  //     for (i = 0; i < 11; i = i + 1) begin
  //       if (b[i] == 1) begin
  //         result = result ^ (a << i);
  //         end
  //       end
  //   end
  // end
  else begin

  wire [2*(k/2)-1:0] albl;
  nmultiplier #(k/2) km1(.a(a[k/2-1:0]), .b(b[k/2-1:0]), .out(albl));

  wire [2*(k-k/2)-1:0] ahbh;
  nmultiplier #(k-k/2) km2(.a(a[k-1:k/2]), .b(b[k-1:k/2]), .out(ahbh));

  wire [2*(k-k/2)-1:0] s_mid;
  nmultiplier #(k-k/2) km3(.a(a[k-1:k/2]^a[k/2-1:0]), .b(b[k-1:k/2]^b[k/2-1:0]), .out(s_mid));
   always @(*) begin
      result=0;
      result=result^albl;
      result=result^(ahbh<<2*s);
      result=result^((s_mid^albl^ahbh)<<s);
    end
  end
  assign out=result;
endmodule
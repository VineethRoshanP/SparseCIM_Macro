//For 64 Rows: 16 two-input 5-bit Adders

module fiveBitAdder (
	input wire [4:0] a,b,
	output reg [5:0] out
);

always @(*) begin
	out = a + b;
end

endmodule

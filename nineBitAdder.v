//For 64 Rows: 1 two-input 9-bit Adders

module nineBitAdder (
	input wire [8:0] a,b,
	output reg [9:0] out
);

always @(*) begin
	out = a + b;
end

endmodule


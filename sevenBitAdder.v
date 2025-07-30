//For 64 Rows: 4 two-input 7-bit Adders

module sevenBitAdder (
	input wire [6:0] a,b,
	output reg [7:0] out
);

always @(*) begin
	out = a + b;
end

endmodule


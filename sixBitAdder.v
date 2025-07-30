//For 64 Rows: 8 two-input 6-bit Adders

module sixBitAdder (
	input wire [5:0] a,b,
	output reg [6:0] out
);

always @(*) begin
	out = a + b;
end

endmodule


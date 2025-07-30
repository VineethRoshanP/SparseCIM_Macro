//For 64 Rows: 2 two-input 8-bit Adders

module eightBitAdder (
	input wire [7:0] a,b,
	output reg [8:0] out
);

always @(*) begin
	out = a + b;
end

endmodule


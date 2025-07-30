//For 64 Rows: 32 two-input 4-bit Adders

module fourBitAdder (
	input wire [3:0] a,b,
	output reg [4:0] out
);

always @(*) begin
	out = a + b;
end

endmodule


//-
// Testbench Module (in the same file)
//-

// First number (1ns) indicates reference time value for all time related operations like delay (#10 = 10ns delay)
// Second number (1ps) indicates the smallest possible time increment for the simulator, defines the Time precision
`timescale 1ns / 1ps

module fourBitAdder_tb;

    reg [3:0] a_tb, b_tb;
    wire [4:0] out_tb;
    
    //DUT: Design Under Test, links the tb file to the design file you want to stimulate and observe.
    fourBitAdder DUT ( //name before "DUT" must match with the name of the design file
    
        //Mapping the ports of the tb and design file:
        .a(a_tb),
        .b(b_tb),
        .out(out_tb)
    );
    
    //To Track the number of errors:
    integer i, j;
    integer error_counter = 0;
    
    initial begin
    
        for(i = 0; i < 16; i = i+1) begin
        
                for(j = 0; j < 16; j = j+1) begin
                
                    //Stimulating inputs of Design File
                    a_tb = i;
                    b_tb = j;
                    
                    //Delay for 10ns to allow log to complete
                    #10;
                    
                    //Checking if DUR's output is incorrect:
                    if(out_tb != (i+j)) begin
                    
					   $display("ERROR! a=%d, b=%d | DUT Output=%d, Expected=%d", a_tb, b_tb, out_tb, i + j);
					   error_counter = error_counter + 1;
                    
                    end
                
                end
        
        end
        
        if (error_counter == 0) begin
        
			$display("--- SUCCESS! All 256 combinations passed.");
			
		end 
		
		else begin
		
			$display("--- FAILURE! Found %0d error(s)", error_counter);
			
		end

        //indicates program to stop simulation, if not included simulation will continue to run unecessarily till a default timelimit is hit
		$finish;
    
    end
    
    
    
endmodule 
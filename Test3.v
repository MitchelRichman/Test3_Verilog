module elevator_display(
	input wire [1:0] floor,
	input wire emergency,
	output reg [3:0] display
);
always @(*) begin
	if (emergency) begin
		display = 4'b1111;
	end else begin 
		case (floor)
			2'd0: display = 4'b0001;
			2'd1: display = 4'b0010;
			2'd2: display = 4'b0100;
			2'd3: display = 4'b1000;
			default: display = 4'b0000;
		endcase 
	end

end

endmodule


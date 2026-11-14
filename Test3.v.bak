module security_system(
	input wire alarm,
	input wire override,
	input wire sensor,
	output wire siren
);
assign siren = ~alarm&(override| sensor);
endmodule










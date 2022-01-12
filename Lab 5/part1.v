
	
module part1(Clock, Enable, Clear_b, CounterValue);
input Clock;
input Enable;
input Clear_b;
output [7:0]CounterValue;
wire wire1, wire2, wire3, wire4, wire5, wire6, wire7;
assign wire1 = Enable & CounterValue[0];
assign wire2 = wire1 & CounterValue[1];
assign wire3 = wire2 & CounterValue[2];
assign wire4 = wire3 & CounterValue[3];
assign wire5 = wire4 & CounterValue[4];
assign wire6 = wire5 & CounterValue[5];
assign wire7 = wire6 & CounterValue[6];

flip_flop_t f1(.Clock(Clock), .Enable(Enable), .Clear_b(Clear_b), .out(CounterValue[0]));
flip_flop_t f2(.Clock(Clock), .Enable(wire1), .Clear_b(Clear_b), .out(CounterValue[1]));
flip_flop_t f3(.Clock(Clock), .Enable(wire2), .Clear_b(Clear_b), .out(CounterValue[2]));
flip_flop_t f4(.Clock(Clock), .Enable(wire3), .Clear_b(Clear_b), .out(CounterValue[3]));
flip_flop_t f5(.Clock(Clock), .Enable(wire4), .Clear_b(Clear_b), .out(CounterValue[4]));
flip_flop_t f6(.Clock(Clock), .Enable(wire5), .Clear_b(Clear_b), .out(CounterValue[5]));
flip_flop_t f7(.Clock(Clock), .Enable(wire6), .Clear_b(Clear_b), .out(CounterValue[6]));
flip_flop_t f8(.Clock(Clock), .Enable(wire7), .Clear_b(Clear_b), .out(CounterValue[7]));

endmodule 

module flip_flop_t(Clock, Enable, Clear_b, out);
input Clock;
input Enable;
input Clear_b;
output reg out;


always @(posedge Clock, negedge Clear_b)
begin
	if(Clear_b == 1'b0)
		out <= 1'b0;
	else 
	begin
		if(Enable == 1'b1)
			out <= ~out;
		else 
			out <= out;
		end
	end

endmodule 

module decoder_6(c0,c1,c2,c3,out);
	input c0,c1,c2,c3;
	output out;
	
	assign out = ~((~c1 & c2) | (c2 & ~c3) | (~c0 & c1 & ~c2) | (c0 & ~c1) | (c0 & c3));
	
endmodule

module decoder_5(c0,c1,c2,c3,out);
	input c0,c1,c2,c3;
	output out;
	
	assign out = ~((~c2 & ~c3) | (~c0 & c1 & ~c2) | (c1 & ~c3) | (c0 & ~c1) | (c0 & c2));
	
endmodule

module decoder_4(c0,c1,c2,c3,out);
	input c0,c1,c2,c3;
	output out;
	
	assign out = ~((~c1 & ~c3) | (c2 & ~c3) | (c0 & c2) | (c0 & c1));
	
endmodule

module decoder_3(c0,c1,c2,c3,out);
	input c0,c1,c2,c3;
	output out;
	
	assign out = ~((~c0 & ~c1 & ~c3) | (~c1 & c2 & c3) | (c1 & ~c2 & c3) | (c1 & c2 & ~c3) | (c0 & ~c2 & ~c3));
	
endmodule

module decoder_2(c0,c1,c2,c3,out);
	input c0,c1,c2,c3;
	output out;
	
	assign out = ~((~c0 & ~c2) | (~c0 & c3) | (~c2 & c3) | (~c0 & c1) | (c0 & ~c1));
	
endmodule

module decoder_1(c0,c1,c2,c3,out);
	input c0,c1,c2,c3;
	output out;
	
	assign out = ~((~c0 & ~c1) | (~c0 & ~c2 & ~c3) | (~c1 & ~c3) | (~c0 & c2 & c3) | (c0 & c3 & ~c2));
	
endmodule

module decoder_0(c0,c1,c2,c3,out);
	input c0,c1,c2,c3;
	output out;
	
	assign out = ~((~c1 & ~c3) | (~c0 & c2) | (~c0 & c1 & c3) | (c1 & c2) | (c0 & ~c1 & ~c2) | (c0 & ~c3));
	
endmodule

module hex_decoder(NUM, HEX);
	input [3:0] NUM;
	output [6:0] HEX;
	
	decoder_0 h0(NUM[3], NUM[2], NUM[1], NUM[0], HEX[0]);
	decoder_1 h1(NUM[3], NUM[2], NUM[1], NUM[0], HEX[1]);
	decoder_2 h2(NUM[3], NUM[2], NUM[1], NUM[0], HEX[2]);
	decoder_3 h3(NUM[3], NUM[2], NUM[1], NUM[0], HEX[3]);
	decoder_4 h4(NUM[3], NUM[2], NUM[1], NUM[0], HEX[4]);
	decoder_5 h5(NUM[3], NUM[2], NUM[1], NUM[0], HEX[5]);
	decoder_6 h6(NUM[3], NUM[2], NUM[1], NUM[0], HEX[6]);
	
endmodule
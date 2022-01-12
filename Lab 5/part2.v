

module part2(ClockIn, Reset, Speed, CounterValue);
	input ClockIn;
    input Reset;
	input [1:0] Speed;
	output [3:0] CounterValue;
	wire Enable;
	wire [10:0] RateDivider;

	RateDivider r_1 (.Speed(Speed), .out(RateDivider), .ClockIn(ClockIn), .Clear_b(Reset));

	assign Enable = (RateDivider == 11'b00000000000) ? 1'b1 : 1'b0;
	
	counter c_1 (.q(CounterValue), .Clock(ClockIn), .Clear_b(~Reset), .Enable(Enable));
	
endmodule

module RateDivider(Speed, out, ClockIn, Clear_b);
	
    input ClockIn;
    input Clear_b;
    input [1:0] Speed;
	
	output reg [10:0] out;
	
	reg [10:0] d;
	
	always @(Speed)
	begin
	case (Speed)
		2'b00: d <= 11'b00000000000;
		2'b01: d <= 11'b00111110011;
		2'b10: d <= 11'b01111100111;
		2'b11: d <= 11'b11111001111;
		default: d <= 11'b00000000000;
	endcase
	end
	
	always@ (posedge ClockIn)
	begin
	
		if(Clear_b)
			out <= 11'b00000000000;
		else if (out == 11'b00000000000)				
			out <= d;
		else  
			out <= out - 1;
		end
	
endmodule

module counter(q, Clock, Clear_b, Enable);
	input Clock;
    input Clear_b;
    input Enable;
	output reg[3:0] q;
	
	always@(posedge Clock)
		begin
			if(Clear_b  ==  1'b0)
				q <= 4'b000;
			else if(Enable)	
				q <= q + 1; 
		end

endmodule 
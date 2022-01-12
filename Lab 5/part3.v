module part3(ClockIn, Resetn, Start, Letter, DotDashOut);
	input [2:0] Letter;
	input Resetn;
    input Start; 
    input ClockIn;
	output DotDashOut;

	reg [11:0] out;
	
	always @(*) 
	begin
	case (Letter[2:0]) 
		3'b000: out = 12'b010111000000; 
		3'b001: out = 12'b011101010100; 
		3'b010: out = 12'b011101011101; 
		3'b011: out = 12'b011101010000; 
		3'b100: out = 12'b010000000000; 
		3'b101: out = 12'b010101110100; 
		3'b110: out = 12'b011101110100; 
		3'b111: out = 12'b010101010000; 
		default: out = 12'b010111000000; 
	endcase
	end
	
	wire Enable;
	RD rd1(ClockIn, Enable, Resetn);
	wire [11:0] shiftedOut;
	reg rotateLeft;
	always @(posedge ClockIn, negedge Resetn)
	begin 
		if(Resetn == 1'b0)
			rotateLeft <= 1'b0;
		else if(Enable == 1'b1)
			rotateLeft <= 1'b1;
		else
			rotateLeft <= 1'b0;
	end
	shiftReg shift(ClockIn, ~Resetn, ~Start, ~rotateLeft, 1'b0, out, shiftedOut, Enable);
	assign DotDashOut = shiftedOut[11];

endmodule

module RD(ClockIn, enable, reset); 
	input ClockIn, reset;
	output reg enable;
	reg [10:0]countDown;
	always @(posedge ClockIn, negedge reset)
	begin
		if(reset == 1'b0)
			begin enable <= 1'b0; countDown <= 11'b00011111001; end
		else if(enable == 1'b1)
			begin enable <= ~enable; countDown <= 11'b00011111001; end 
		else if(countDown == 11'b00000000001)
			enable <= 1'b1;
		else 
			countDown <= countDown-1;
	end
endmodule 

module shiftReg(clock, reset, ParallelLoadn, RotateRight, ASRight, in_data, Q, Enable);
	input [11:0] in_data;
	output [11:0] Q;
	input clock, reset, ParallelLoadn, RotateRight, ASRight, Enable;
	
	flip_flop_d_mx ffdmx11(in_data[11], ParallelLoadn, RotateRight, Q[10], Q[11], reset, clock, Q[11]);
	flip_flop_d_mx ffdmx10(in_data[10], ParallelLoadn, RotateRight, Q[9], Q[10], reset, clock, Q[10]);
	flip_flop_d_mx ffdmx9(in_data[9], ParallelLoadn, RotateRight, Q[8], Q[9], reset, clock, Q[9]);
	flip_flop_d_mx ffdmx8(in_data[8], ParallelLoadn, RotateRight, Q[7], Q[8], reset, clock, Q[8]);
	flip_flop_d_mx ffdmx7(in_data[7], ParallelLoadn, RotateRight, Q[6], Q[7], reset, clock, Q[7]);
	flip_flop_d_mx ffdmx6(in_data[6], ParallelLoadn, RotateRight, Q[5], Q[6], reset, clock, Q[6]);
	flip_flop_d_mx ffdmx5(in_data[5], ParallelLoadn, RotateRight, Q[4], Q[5], reset, clock, Q[5]);
	flip_flop_d_mx ffdmx4(in_data[4], ParallelLoadn, RotateRight, Q[3], Q[4], reset, clock, Q[4]);
	flip_flop_d_mx ffdmx3(in_data[3], ParallelLoadn, RotateRight, Q[2], Q[3], reset, clock, Q[3]);
	flip_flop_d_mx ffdmx2(in_data[2], ParallelLoadn, RotateRight, Q[1], Q[2], reset, clock, Q[2]);
	flip_flop_d_mx ffdmx1(in_data[1], ParallelLoadn, RotateRight, Q[0], Q[1], reset, clock, Q[1]);
	flip_flop_d_mx ffdmx0(in_data[0], ParallelLoadn, RotateRight, Q[11], Q[0], reset, clock, Q[0]);
	
endmodule

module flip_flop_d(d, clk, resetn, q); 
	input d,clk,resetn;
	output reg q;
	always @(posedge clk, negedge resetn)
		begin
			if(resetn == 1'b1)
				q <= 0;
			else
				q <= d;
		end
endmodule 

module flip_flop_d_mx(D, loadn, LoadLeft, right, left, resetn, clk, Q);
	input D, loadn, LoadLeft, right, left, resetn, clk;
	output Q;
	wire wire1, wire2; 
	
	mux2to1 M1(right, left, LoadLeft, wire1);
	mux2to1 M2(D, wire1,loadn, wire2);
	flip_flop_d ff0(wire2, clk, resetn, Q);
	
endmodule



module mux2to1(x, y, s, m);
    input x; 
    input y; 
    input s; 
    output m; 
        
    assign m = s ? y : x;

endmodule
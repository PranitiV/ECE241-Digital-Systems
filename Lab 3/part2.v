module full_adder(A, B, cin, S, cout);
	input A, B, cin;
	output S, cout;
	
	assign S = A ^ B ^ cin;
	assign cout = ((A & B)| (cin & B) | (cin & A));
endmodule

module part2(a, b, c_in, s, c_out);
	
	input [3:0] a;
	input [3:0] b;
	input c_in; 
	output [3:0] s;
	output [3:0] c_out;

	full_adder fa0(a[0], b[0], c_in, s[0], c_out[0]);
	full_adder fa1(a[1], b[1],  c_out[0], s[1], c_out[1]);
	full_adder fa2(a[2], b[2],  c_out[1], s[2], c_out[2]);
	full_adder fa3(a[3], b[3],  c_out[2], s[3], c_out[3]);

endmodule 
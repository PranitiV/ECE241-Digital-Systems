module hex_decoder(c, display);
	input[3:0] c;
	output[6:0] display;

	wire a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12 , a13, a14, a15;
	assign a0 = (~c[3] & ~c[2] & ~c[1] & ~c[0]);
	assign a1 = (~c[3] & ~c[2] & ~c[1] & c[0]);
	assign a2 = (~c[3] & ~c[2] & c[1] & ~c[0]);
	assign a3 = (~c[3] & ~c[2] & c[1] & c[0]);
	assign a4 = (~c[3] & c[2] & ~c[1] & ~c[0]);
	assign a5 = (~c[3] & c[2] & ~c[1] & c[0]);
	assign a6 = (~c[3] & c[2] & c[1] & ~c[0]);
	assign a7 = (~c[3] & c[2] & c[1] & c[0]);
	assign a8 = (c[3] & ~c[2] & ~c[1] & ~c[0]);
	assign a9 = (c[3] & ~c[2] & ~c[1] & c[0]);
	assign a10 = (c[3] & ~c[2] & c[1] & ~c[0]);
	assign a11 = (c[3] & ~c[2] & c[1] & c[0]);
	assign a12 = (c[3] & c[2] & ~c[1] & ~c[0]);
	assign a13 = (c[3] & c[2] & ~c[1] & c[0]);
	assign a14 = (c[3] & c[2] & c[1] & ~c[0]);
	assign a15 = (c[3] & c[2] & c[1] & c[0]);

	assign display[0] = ~(a0 | a2 | a3 | a5 | a6 | a7 | a8 | a9 | a10 | a12 | a14 | a15);
	assign display[1] = ~(a0 | a1 | a2 | a3 | a4 | a7 | a8 | a9 | a10 | a12 | a13);
	assign display[2] = ~(a0 | a1 | a3 | a4 | a5 | a6 | a7 | a8 | a9 | a10 | a11 | a13);
	assign display[3] = ~(a0 | a2 | a3 | a5 | a6 | a8 | a9 | a11 | a12 | a13 | a14);
	assign display[4] = ~(a0 | a2 | a6 | a8 | a10 | a11 | a12 | a13 | a14 | a15);
	assign display[5] = ~(a0 | a4 | a5 | a6 | a8 | a9 | a10 | a11 | a12 | a14 | a15);
	assign display[6] = ~(a2 | a3 | a4 | a5 | a6 | a8 | a9 | a10 | a11 | a13 | a14 | a15);

endmodule 

module v7408 (pin1, pin2, pin4, pin5, pin9, pin10, pin13, pin12,
              pin3, pin6, pin11, pin8);
	input pin1, pin2, pin4, pin5, pin9, pin10, pin13, pin12;
	output pin3, pin6, pin11, pin8;

	assign pin3=pin1&pin2;
	assign pin6=pin4&pin5;
	assign pin11=pin13&pin12;
	assign pin8=pin9&pin10;

endmodule

module v7432(pin1, pin2, pin4, pin5, pin9, pin10, pin13, pin12,
              pin3, pin6, pin11, pin8);

 	input pin1, pin2, pin4, pin5, pin9, pin10, pin13, pin12;
	output pin3, pin6, pin11, pin8;

	assign pin3=pin1|pin2;
	assign pin6=pin4|pin5;
	assign pin11=pin13|pin12;
	assign pin8=pin9|pin10;

endmodule

module v7404(pin1, pin3, pin5, pin13, pin11, pin9,
             pin2, pin4, pin6, pin8, pin10, pin12);

	input pin1, pin3, pin5, pin13, pin11, pin9;
	output pin2, pin4, pin6, pin8, pin10, pin12;

	assign pin2=~pin1;
	assign pin4=~pin3;
	assign pin6=~pin5;
	assign pin12=~pin13;
	assign pin10=~pin11;
	assign pin8=~pin9;

endmodule

module mux2to1(x, y, s, m);
	input x,y,s;
	output m;
	
	wire c1,c2,c3;
	v7404 u1 (.pin1(s),.pin2(c1));
	v7408 u2 (.pin1(c1),.pin2(x),.pin3(c2));
	v7408 u3 (.pin4(s),.pin5(y),.pin6(c3));
	v7432 u4 (.pin1(c2),.pin2(c3),.pin3(m));
endmodule

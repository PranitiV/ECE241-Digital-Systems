
module module_control (iResetn, iClock, iLoadX, iPlotBox, c, a, b, e, oPlot);
	input iResetn;
    input iClock;
    input iLoadX;
    input iPlotBox;
	input [3:0] c;
	reg [2:0] current_state, next_state;
	output reg a, b, e, oPlot;

	localparam S_L_X = 3'd0,
				  S_L_X_W = 3'd1,
				  S_L_Y = 3'd2,
				  S_L_Y_W = 3'd3,
				  S_D = 3'd4,
				  S_D_W = 3'd5;
				  
	always@(posedge iClock)
	begin
		if(!iResetn)
			current_state <= S_L_X;
		else 
			current_state <= next_state;
	end
	
	always@(*)
		begin		
			a = 0;
			b = 0;
			e = 0;
			case(current_state)
				S_L_X:
				begin
					a = 1'd1;
					oPlot = 0;
				end
				S_L_Y: b = 1'd1;
				S_D: begin
					e = 1'd1;
					oPlot = 1'd1;
				end
			endcase
		end
				  
	always@(*)
		begin
			case(current_state)
				S_L_X: next_state = iLoadX ? S_L_X_W : S_L_X; 
				S_L_X_W: next_state = iLoadX ? S_L_X_W : S_L_Y;
				S_L_Y: next_state = iPlotBox ? S_L_Y_W : S_L_Y;
				S_L_Y_W: next_state = iPlotBox ? S_L_Y_W : S_D;
				S_D : begin
					if (c == 4'd15)
						next_state = S_D_W;
					else 
						next_state = S_D;
					end
				S_D_W: next_state = S_L_X;
				default : next_state = S_L_X;
			endcase
		end	
endmodule

module module_datapath (iResetn, iClock, iXY_Coord, iColour, a, b, e, c, oX, oY, oColour);
	input iResetn;
    input iClock;
    input e;
    input a;
    input b;
	
	input [2:0] iColour;
    input [6:0] iXY_Coord;

	reg [2:0] reg_col;
    reg [6:0] y_count;
    reg [7:0] x_count;

	output reg [3:0] c;
	output reg [7:0] oX;
	output reg [6:0] oY;
	output reg [2:0] oColour;

	
	always@(posedge iClock)
	begin
		if (!iResetn)
			c <= 4'b0;
		else if (e)
			c <= c + 1;	
		else if (c == 4'd15)
			c <= 4'd0;
	end
	
	always@(posedge iClock)
		begin 
			if (iResetn==0)
				begin
					oX <= 0;
					oY <= 0;
					oColour <= 0;
				end
			else 
				begin 
					if (a)
						begin
							x_count <= {1'b0, iXY_Coord};
						end
					else if(e)
						begin
							oX <= x_count + c[1:0];
							oY <= y_count + c[3:2];
							oColour <= reg_col;
						end

					else if (b)
						begin
							y_count <= iXY_Coord;
							reg_col <= iColour;
						end
				end
		
			end

endmodule

module part2(iResetn,iPlotBox,iBlack,iColour,iLoadX,iXY_Coord,iClock,oX,oY,oColour,oPlot);
   parameter X_SCREEN_PIXELS = 8'd160;
   parameter Y_SCREEN_PIXELS = 7'd120;
   
   input wire iResetn, iPlotBox, iBlack, iLoadX;
   input wire [2:0] iColour;
   input wire [6:0] iXY_Coord;
   input wire 	iClock;
   output wire [7:0] oX;        
   output wire [6:0] oY;   
   output wire [2:0] oColour;    
   output wire oPlot;       
	
	wire [3:0] c;
    wire a, b, e;

	module_control  c_c(.iResetn(iResetn),.iClock(iClock),.iLoadX(iLoadX),.iPlotBox(iPlotBox),.c(c),.a(a),.b(b),.e(e),.oPlot(oPlot));
	module_datapath d(.iResetn(iResetn), .iClock(iClock), .iXY_Coord(iXY_Coord), .iColour(iColour), .a(a), .b(b), .e(e), .c(c), .oX(oX), .oY(oY), .oColour(oColour));
   
endmodule 
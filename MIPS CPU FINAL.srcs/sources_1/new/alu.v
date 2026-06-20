`timescale 1ns / 1ps

module ALU(
    input   [31:0] A, B,
    input   [3:0] control,
    output  reg [31:0] result
    );
    
    always@(*) begin
        case (control)
            4'd1: result = A + B;
            4'd3: result = A - B;
            4'd4: result = A & B;
            4'd5: result = A | B;
            4'd6: result = A ^ B;
            4'd7: result = ~(A | B);
            4'd8: result = A >> B[4:0];
            4'd9: result = A << B[4:0];
            4'd10: result = $signed(A) >>> B[4:0];
            4'd11: result = ($signed(A) < $signed(B)) ? 1 : 0;
            4'd12: result = (A < B) ? 1 : 0;
            4'd13: result = A;
            4'd14: result = B;
            4'd15: result = B << 16;
            default: result = 0;
        endcase  
    end

endmodule

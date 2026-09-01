`timescale 1ns / 1ps

module MDU(
    input clk,
    input reset_start, 
    input [2:0] control,
    input [31:0] A, B,
    output reg [31:0] result,
    output div_done,
    output div_flush
);

    reg [31:0] mfhi;
    reg [31:0] mflo;
    
    reg A_sign;
    reg B_sign; 
    reg signed_div_reg;
   
    wire [63:0] div_result;
    wire div_busy;
    
    wire is_div = (control == 3'b011 || control == 3'b100);
    assign div_flush = (is_div || div_busy);

    wire signed_div = (control == 3'b011);
    wire [31:0] dividend = (signed_div && A[31]) ? (~A + 1'b1) : A;
    wire [31:0] divisor = (signed_div && B[31]) ? (~B + 1'b1) : B;

    unsigned_divider_32b g8_1(clk, reset_start, dividend, divisor, div_busy, 
        div_result, div_done);
    
    always @(posedge clk) begin
        if (reset_start) begin
            A_sign <= A[31];
            B_sign <= B[31];
            signed_div_reg <= (control == 3'b011);
        end 
    end

    always @(posedge clk) begin
        if (control == 3'b001)
            {mfhi, mflo} <= $signed(A) * $signed(B);
        else if (control == 3'b010)
            {mfhi, mflo} <= A * B;
        else if (div_done) begin
            if (signed_div_reg) begin 
                if (A_sign)
                    mfhi <= ~div_result[63:32] + 1'b1;
                else 
                    mfhi <= div_result[63:32];
                if (A_sign ^ B_sign) 
                    mflo <= ~div_result[31:0] + 1'b1;
                else
                    mflo <= div_result[31:0];
            end
            else 
                {mfhi, mflo} <= div_result;
        end
    end

    always @(*) begin
        result = 32'b0;
        case (control)
            3'b101: result = mfhi;
            3'b110: result = mflo;
            default: result = 32'b0;
        endcase
    end

endmodule


module unsigned_divider_32b(
    input clk,
    input reset_start,
    input [31:0] dividend,
    input [31:0] divisor,
    output reg busy,
    output reg [63:0] div_result,
    output reg div_done
);

    reg [1:0] state;
    localparam IDLE = 2'b00;
    localparam BUSY = 2'b01;
    localparam DONE = 2'b10;

    reg [32:0] A;
    reg [31:0] Q;
    reg [31:0] M;
    wire [32:0] A_shifted;
    integer i;

    assign A_shifted = {A[31:0], Q[31]};
    
    initial begin
        state = IDLE;
        A = 0;
        Q = 0;
        M = 0;
        i = 0;
        busy = 0;
        div_done = 0;
        div_result = 0;
    end

    always @(posedge clk) begin
        div_done <= 0;

        case (state)
            IDLE: begin
                i <= 0;
                busy <= 0;

                if (reset_start) begin
                    busy <= 1;
                    A <= 33'b0;
                    Q <= dividend;
                    M <= divisor;
                    state <= BUSY;
                end
            end

            BUSY: begin
                if (i < 32) begin
                    if (A_shifted >= {1'b0, M}) begin
                        A <= A_shifted - {1'b0, M};
                        Q <= {Q[30:0], 1'b1};
                    end
                    else begin
                        A <= A_shifted;
                        Q <= {Q[30:0], 1'b0};
                    end
                    i <= i + 1;
                end
                else begin
                    state <= DONE;
                end
            end

            DONE: begin
                div_result <= {A[31:0], Q};
                div_done <= 1;
                busy <= 0;
                state <= IDLE;
            end

            default: state <= IDLE;
        endcase
    end

endmodule

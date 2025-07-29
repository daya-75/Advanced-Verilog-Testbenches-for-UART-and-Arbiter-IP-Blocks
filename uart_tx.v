
module uart_tx (
    input wire clk,
    input wire rst,
    input wire start,
    input wire [7:0] data_in,
    output reg tx,
    output reg busy
);

    parameter CLK_PER_BIT = 16;  
    reg [3:0] bit_index;
    reg [7:0] data;
    reg [4:0] clk_count;
    reg [3:0] state;

    localparam IDLE  = 0,
               START = 1,
               DATA  = 2,
               STOP  = 3,
               CLEANUP = 4;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx <= 1'b1;
            busy <= 1'b0;
            state <= IDLE;
            clk_count <= 0;
            bit_index <= 0;
        end else begin
            case (state)
                IDLE: begin
                    tx <= 1'b1;
                    clk_count <= 0;
                    bit_index <= 0;
                    busy <= 0;
                    if (start) begin
                        data <= data_in;
                        state <= START;
                        busy <= 1;
                    end
                end

                START: begin
                    tx <= 0;
                    if (clk_count < CLK_PER_BIT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        state <= DATA;
                    end
                end

                DATA: begin
                    tx <= data[bit_index];
                    if (clk_count < CLK_PER_BIT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        if (bit_index < 7)
                            bit_index <= bit_index + 1;
                        else
                            state <= STOP;
                    end
                end

                STOP: begin
                    tx <= 1;
                    if (clk_count < CLK_PER_BIT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        state <= CLEANUP;
                    end
                end

                CLEANUP: begin
                    busy <= 0;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule

module priority_arbiter (
    input wire clk,
    input wire rst,
    input wire [3:0] req,     // Request lines
    output reg [3:0] grant    // Grant lines
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            grant <= 4'b0000;
        end else begin
            casez (req)
                4'b1???: grant <= 4'b1000;
                4'b01??: grant <= 4'b0100;
                4'b001?: grant <= 4'b0010;
                4'b0001: grant <= 4'b0001;
                default: grant <= 4'b0000;
            endcase
        end
    end
endmodule

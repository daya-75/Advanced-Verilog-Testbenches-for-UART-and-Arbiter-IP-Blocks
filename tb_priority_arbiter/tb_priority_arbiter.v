`timescale 1ns/1ps

module tb_priority_arbiter;

  reg clk, rst;
  reg [3:0] req;
  wire [3:0] grant;

  priority_arbiter uut (
    .clk(clk),
    .rst(rst),
    .req(req),
    .grant(grant)
  );

  always #5 clk = ~clk;

  initial begin
    $display("---- Priority Arbiter Test Start ----");
    $dumpfile("priority_arbiter.vcd");
    $dumpvars(0, tb_priority_arbiter);

    clk = 0;
    rst = 1;
    req = 4'b0000;
    #10 rst = 0;
    repeat (10) begin
      @(negedge clk);
      req = $random % 16;
      $display("[%0t] Request: %b", $time, req);
    end

    #100;
    $display("---- Priority Arbiter Test End ----");
    $finish;
  end
  always @(posedge clk) begin
    $display("[%0t] REQ=%b GRANT=%b", $time, req, grant);

    if (!rst && req != 0 && grant == 0) begin
      $display("ERROR: Grant not issued despite active request at %0t", $time);
      $stop;
    end
    if (grant !== 0 && (grant & (grant - 1)) !== 0) begin
      $display("FAILURE: Multiple grants active at time %0t", $time);
      $stop;
    end
  end
endmodule

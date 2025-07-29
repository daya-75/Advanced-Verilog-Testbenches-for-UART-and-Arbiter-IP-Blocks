`timescale 1ns/1ps

module tb_uart_tx;
  reg clk, rst, start;
  reg [7:0] data_in;
  wire tx;
  wire busy;
  uart_tx #(.CLK_PER_BIT(4)) uut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .data_in(data_in),
    .tx(tx),
    .busy(busy)
  );
  always #5 clk = ~clk;
  initial begin
    $display("---- UART TX Test Start ----");
    $dumpfile("uart_tx.vcd");
    $dumpvars(0, tb_uart_tx);

    clk = 0;
    rst = 1;
    start = 0;
    data_in = 8'h00;

    #20 rst = 0;

    repeat (5) begin
      @(negedge clk);
      while (busy) @(negedge clk); // Wait if busy

      data_in = $random % 256;
      start = 1;
      $display("[%0t] Sending Byte: %02X", $time, data_in);
      @(negedge clk);
      start = 0;
    end

    #200;
    $display("---- UART TX Test End ----");
    $finish;
  end

  always @(posedge clk) begin
    $display("[%0t] TX=%b, BUSY=%b", $time, tx, busy);

    if (!rst && busy && tx === 1'bx) begin
      $display("ERROR: TX undefined during transmission at %0t", $time);
      $stop;
    end
  end
endmodule

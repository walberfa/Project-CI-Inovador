module alu_simple_tb();
  logic clock, reset;
  logic [7:0] A, B;     // ALU 8-bit Inputs  
  logic [3:0] ALU_Sel;  // ALU Selection
  logic [7:0] ALU_Out;  // ALU 8-bit Output
  logic CarryOut;       // Carry Out Flag

  alu dut1 (
    .clock(clock),
    .reset(reset),
    .A(A),
    .B(B),
    .ALU_Sel(ALU_Sel),
    .ALU_Out(ALU_Out),
    .CarryOut(CarryOut)
  );

  initial begin
    clock = 0;
    forever #5 clock = ~clock;
  end

  initial begin
    reset = 1;
    #10;

    reset = 0;
    
    A = 8'h0A;          // 10
    B = 8'h05;          // 5
    ALU_Sel = 4'b0000;  // Addition. Expected output: 15
    #10;

    A = 8'hFF;          // 255
    B = 8'h01;          // 1
    ALU_Sel = 4'b0000;  // Addition. Expected output: 256 (0 + CarryOut)
    #10;

    A = 8'h0A;          // 10
    B = 8'h02;          // 2
    ALU_Sel = 4'b0001;  // Subtraction. Expected output: 8
    #10;

    A = 8'h0C;          // 12
    B = 8'h03;          // 3
    ALU_Sel = 4'b0001;  // Subtraction. Expected output: 9
    #10;

    A = 8'h0B;          // 11
    B = 8'h05;          // 5
    ALU_Sel = 4'b0010;  // Multiplication. Expected output: 55
    #10;

    A = 8'h0A;          // 10
    B = 8'h00;          // 0    
    ALU_Sel = 4'b0010;  // Multiplication. Expected output: 0
    #10;

    A = 8'hFF;          // 255
    B = 8'h02;          // 2
    ALU_Sel = 4'b0010;  // Multiplication. Expected output: 254 + CarryOut
    #10;

    A = 8'h0A;          // 10
    B = 8'h02;          // 2
    ALU_Sel = 4'b0011;  // Division. Expected output: 5
    #10;

    A = 8'h9B;          // 155
    B = 8'h0A;          // 10
    ALU_Sel = 4'b0011;  // Division. Expected output: 15.5 rounded to 15
    #10;

    A = 8'h02;          // 2
    B = 8'h00;          // 0
    ALU_Sel = 4'b0011;  // Division. Expected output: x (Zero division error)
    #10;

    A = 8'hFF;          // 255
    B = 8'h00;          // 0
    ALU_Sel = 4'b1000;  // Invalid. Expected output: 172 (random BAD value)
    #10;
    
    $finish;
  end


  initial begin
    $display("                 Time  ALU_Sel     A       B    ALU_Out  CarryOut");
    $monitor($time, "     %b    %d     %d     %d        %b", ALU_Sel, A, B, ALU_Out, CarryOut);
  end


  endmodule
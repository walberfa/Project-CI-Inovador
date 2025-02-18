module self_checking_tb();
  logic clock, reset;
  logic [7:0] A, B;     // ALU 8-bit Inputs  
  logic [3:0] ALU_Sel;  // ALU Selection
  logic [7:0] ALU_Out;  // ALU 8-bit Output
  logic CarryOut;       // Carry Out Flag

  alu dut2 (
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
    ALU_Sel = 4'b0000;  // Addition
    #10;

    assert(ALU_Out == 8'h0F) else $display("==========> Test 1 failed. Expected: 15, Output: %d", ALU_Out);
    assert(CarryOut == 0) else $display("==========> Test 1 failed. Expected: CarryOut 0, Output: CarryOut %b", CarryOut);

    A = 8'hFF;          // 255
    B = 8'h01;          // 1
    ALU_Sel = 4'b0000;  // Addition
    #10;

    assert(ALU_Out == 8'h00) else $display("==========> Test 2 failed. Expected: 0, Output: %d", ALU_Out);
    assert(CarryOut == 1) else $display("==========> Test 2 failed. Expected: CarryOut 1, Output: CarryOut %b", CarryOut);

    A = 8'h0A;          // 10
    B = 8'h02;          // 2
    ALU_Sel = 4'b0001;  // Subtraction
    #10;

    assert(ALU_Out == 8'h08) else $display("==========> Test 3 failed. Expected: 8, Output: %d", ALU_Out);
    assert(CarryOut == 0) else $display("==========> Test 3 failed. Expected: CarryOut 0, Output: CarryOut %b", CarryOut);

    A = 8'h0C;          // 12
    B = 8'h03;          // 3
    ALU_Sel = 4'b0001;  // Subtraction
    #10;

    assert(ALU_Out == 8'h09) else $display("==========> Test 4 failed. Expected: 9, Output: %d", ALU_Out);
    assert(CarryOut == 0) else $display("==========> Test 4 failed. Expected: CarryOut 0, Output: CarryOut %b", CarryOut);

    A = 8'h0B;          // 11
    B = 8'h05;          // 5
    ALU_Sel = 4'b0010;  // Multiplication
    #10;

    assert(ALU_Out == 8'h37) else $display("==========> Test 5 failed. Expected: 55, Output: %d", ALU_Out);
    assert(CarryOut == 0) else $display("==========> Test 5 failed. Expected: CarryOut 0, Output: CarryOut %b", CarryOut);

    A = 8'h0A;          // 10
    B = 8'h00;          // 0    
    ALU_Sel = 4'b0010;  // Multiplication
    #10;

    assert(ALU_Out == 8'h00) else $display("==========> Test 6 failed. Expected: 0, Output: %d", ALU_Out);
    assert(CarryOut == 0) else $display("==========> Test 6 failed. Expected: CarryOut 0, Output: CarryOut %b", CarryOut);

    A = 8'hFF;          // 255
    B = 8'h02;          // 2
    ALU_Sel = 4'b0010;  // Multiplication
    #10;

    assert(ALU_Out == 8'hFE) else $display("==========> Test 7 failed. Expected: 254, Output: %d", ALU_Out);
    assert(CarryOut == 1) else $display("==========> Test 7 failed. Expected: CarryOut 1, Output: CarryOut %b", CarryOut);

    A = 8'h0A;          // 10
    B = 8'h02;          // 2
    ALU_Sel = 4'b0011;  // Division
    #10;

    assert(ALU_Out == 8'h05) else $display("==========> Test 8 failed. Expected: 5, Output: %d", ALU_Out);
    assert(CarryOut == 0) else $display("==========> Test 8 failed. Expected: CarryOut 0, Output: CarryOut %b", CarryOut);

    A = 8'h9B;          // 155
    B = 8'h0A;          // 10
    ALU_Sel = 4'b0011;  // Division
    #10;

    assert(ALU_Out == 8'h0F) else $display("==========> Test 9 failed. Expected: 15, Output: %d", ALU_Out);
    assert(CarryOut == 0) else $display("==========> Test 9 failed. Expected: CarryOut 0, Output: CarryOut %b", CarryOut);

    A = 8'h02;          // 2
    B = 8'h00;          // 0
    ALU_Sel = 4'b0011;  // Division
    #10;

    assert(ALU_Out === 8'hxx) else $display("==========> Test 10 failed. Expected: error, Output: %d", ALU_Out);

    A = 8'hFF;          // 255
    B = 8'h00;          // 0
    ALU_Sel = 4'b1000;  // Invalid
    #10;

    assert(ALU_Out == 8'hAC) else $display("==========> Test 11 failed. Expected: 172 (random BAD value), Output: %d", ALU_Out);
    
    $finish; 
  end

endmodule
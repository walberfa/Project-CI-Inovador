module test_vector_tb();
  logic clock, reset;
  logic [7:0] A, B;     // ALU 8-bit Inputs  
  logic [3:0] ALU_Sel;  // ALU Selection
  logic [7:0] ALU_Out;  // ALU 8-bit Output
  logic CarryOut;       // Carry Out Flag
  
  logic [31:0] data [0:15]; // array of testvectors
  logic [8:0] a_tv [0:15];
  logic [8:0] b_tv [0:15];
  logic [3:0] sel_tv [0:15];
  logic [8:0] out_tv [0:15];
  logic carry_tv [0:15];

  alu dut3 (
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
    int i;
    int correct, wrong;

    correct = 0;
    wrong = 0;

    reset = 1;

    #10 reset = 0;

    $readmemh("test_vector.txt", data);

    for (i = 0; i < 16; i++) begin
      sel_tv[i] = data[i][31:28];
      a_tv[i] = data[i][27:20];
      b_tv[i] = data[i][19:12];
      out_tv[i] = data[i][11:4];
      carry_tv[i] = data[i][3:0];
    end

    for (i = 0; i < 16; i++) begin
      A = a_tv[i];
      B = b_tv[i];
      ALU_Sel = sel_tv[i];
      #10;
      if (ALU_Out === out_tv[i] && CarryOut == carry_tv[i]) begin
        correct = correct + 1;
      end else begin
        wrong = wrong + 1;
        $display("==========> Test %d failed. Expected: %d, Output: %d", i, out_tv[i], ALU_Out);
      end
    end

    $display("+------------------------------------------------+");
    $display("Correct: %d", correct);
    $display("Wrong: %d", wrong);

    $finish;
  end

  initial begin
    $display("                 Time  ALU_Sel     A       B    ALU_Out  CarryOut");
    $monitor($time, "     %b    %d     %d     %d        %b", ALU_Sel, A, B, ALU_Out, CarryOut);
  end

endmodule
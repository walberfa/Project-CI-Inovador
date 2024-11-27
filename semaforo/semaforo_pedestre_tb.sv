//Visualizar a saída através de forma de onda

`timescale 1ns/10ps
 
module tb_sp();
logic clk=0, rst=0, botao_pedestre=0;
logic Q1, Q2, Q3, Q4, Q5;

semaforo_pedestre sp1(.clk(clk), .rst(rst), .botao_pedestre(botao_pedestre),
			.Q1(Q1), .Q2(Q2), .Q3(Q3), .Q4(Q4), .Q5(Q5));

initial begin
	clk = 0;
	forever #1 clk = ~clk;
end

initial begin
	$dumpfile("semaforo_pedestre.vcd");
    $dumpvars;

	rst = 1;
	#5ns;
	rst = 0;
        
	while(1)
    begin
        botao_pedestre = 1;
        @(posedge clk);
        #2;
        botao_pedestre = 0;
        #40;
    end
end

initial begin
	#200
	rst = 1;
	#10
	$finish;
end

endmodule

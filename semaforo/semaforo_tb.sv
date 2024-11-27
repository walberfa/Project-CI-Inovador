`timescale 1ns/10ps
 
module tb();
logic clk=0, rst=0, pulso=0;
logic vermelho, verde, amarelo;

semaforo s1(.clk(clk), .rst(rst), .pulso(pulso),
			.verde(verde), .amarelo(amarelo), .vermelho(vermelho));

initial begin
	clk = 0;
	forever #1 clk = ~clk;
end

initial begin
	rst = 1;
	#5ns;
	rst = 0;
        
	while(1)
    begin
        pulso = 1;
        @(posedge clk);
        #2;
        pulso = 0;
        #20;
    end
end

initial begin
	#200
	rst = 1;
	#10
	$finish;
end

initial begin
	$display("		Time	   Semáforo");
	$monitor($time, " > Vm:%b Am:%b Vd:%b", vermelho, amarelo, verde);
end

endmodule

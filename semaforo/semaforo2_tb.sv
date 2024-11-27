`timescale 1ns/10ps
 
module tb2();
logic clk=0, rst=0, pulso=0;
logic rua_1_vermelho, rua_1_verde, rua_1_amarelo;
logic rua_2_vermelho, rua_2_verde, rua_2_amarelo;

semaforo2 s2(.clk(clk), .rst(rst), .pulso(pulso),
			.rua_1_verde(rua_1_verde), .rua_1_amarelo(rua_1_amarelo), .rua_1_vermelho(rua_1_vermelho),
            .rua_2_verde(rua_2_verde), .rua_2_amarelo(rua_2_amarelo), .rua_2_vermelho(rua_2_vermelho));

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
	$display("		Time    Semáforo Rua 1       Semáforo Rua 2");
	$monitor($time, " > Vm:%b Am:%b Vd:%b       Vm:%b Am:%b Vd:%b", 
    rua_1_vermelho, rua_1_amarelo, rua_1_verde,
    rua_2_vermelho, rua_2_amarelo, rua_2_verde);
end

endmodule

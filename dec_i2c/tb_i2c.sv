/*
Segunda questão Prova de Lógica Digital
Walber Florencio de Almeida
28 Nov 24
Polo UFC 
Testbench (item 2.7)
Visualização da forma de onda via comando:
    "xrun tb_i2c.sv dec_i2c.sv -gui -access +rwc"
*/

`timescale 1ns/10ps
module tb();
reg clk, reset, sda, scl;
reg [7:0] dado;
parameter SCL_PERIOD = 100;
logic operacao, escrita, stop;
logic [6:0] endereco_recebido;

//Instanciação do módulo dec_i2c
dec_i2c dec_i2c_inst(
    .clk(clk),
    .reset(reset),
    .sda(sda),
    .scl(scl),
    .endereco_local(dado[7:1]),
    .pronto(dado[0]),
    .operacao(operacao),
    .escrita(escrita),
    .stop(stop),
    .endereco_recebido(endereco_recebido)
    );

//Pulso do clock
initial begin
    clk = 0;
    forever #10 clk = ~clk;
end

//Execução do teste
initial
begin
        reset = 0;
        #(SCL_PERIOD / 2);
        reset = 1;
        sda = 1;
        scl = 0;
        dado = 8'b11001000; // Exemplo de dado para envio
        #(SCL_PERIOD *2);
        scl = 1;
        #(SCL_PERIOD / 2);
        scl = 0;
        #(SCL_PERIOD / 2);
        scl = 1;
        
        // START condition (sda: HIGH -> LOW quando scl está em HIGH)
        #(SCL_PERIOD / 2);
        sda = 0;
        #(SCL_PERIOD / 2);
        
        // Envio do byte de dados (8 bits, MSB primeiro)
        for (int i = 7; i >= 0; i--) begin
            scl = 0;                     // Baixa scl para preparar dados
            #(SCL_PERIOD / 3);
            
            sda = dado[i];          // Configura bit no sda
            #(SCL_PERIOD / 3);
            scl = 1;                     // Pulso de clock
            #(SCL_PERIOD / 3);
        end
        
        // Bit de ACK/NACK (do slave)
        scl = 0;                         // Baixa scl para preparar o ACK
        #(SCL_PERIOD / 3);
        sda = 0;                       // ACK/NACK no sda
        #(SCL_PERIOD / 3);
        scl = 1;                         // Pulso de clock para ACK
        #(SCL_PERIOD / 3);
        scl = 0;

        // STOP condition (sda: LOW -> HIGH quando scl está em HIGH)
        sda = 0;
        #(SCL_PERIOD / 2);
        scl = 1;
        #(SCL_PERIOD / 2);
        sda = 1;

        #(SCL_PERIOD *5);
        // Finalização da simulação
        $finish;

end

initial
begin
    $display("Comecou o teste");
    $dumpfile("test_prova_Walber.vcd");
    $dumpvars(0,tb);    
    $timeformat(-9, 2, " ns", 20);
    end

endmodule

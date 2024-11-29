/*
Segunda questão Prova de Lógica Digital
Walber Florencio de Almeida
28 Nov 24
Polo UFC 
*/

`timescale 1ns/10ps

//Interface do módulo dec_i2c (item 2.1)
module dec_i2c (
    input logic clk, reset, sda, scl, pronto,
    input logic [6:0] endereco_local,
    output logic operacao, escrita, stop,
    output logic [6:0] endereco_recebido
);

typedef enum { START, R0, R1, R2, R3, R4, R5, R6, OPERACAO, STOP } estados; //enumeração dos estados

estados prox_estado;
estados estado_atual;

reg [7:0] addr_ff; 
reg start_cond, stop_cond, scl_anterior;
wire sobe_scl;

always@(posedge clk) //atualiza estado no pulso do clock
    begin
        estado_atual <= prox_estado;
end

always@(posedge clk) //salva o status do scl
    begin: salva_scl_anterior
        scl_anterior <= scl;
end

//detecta borda de subida no scl (item 2.2)
assign sobe_scl = ((scl==1) && (scl_anterior==0));

//Detectar condições star e stop (item 2.2)
always_comb begin: detecta_start_and_stop_conditions
    if(sda==0 && scl==1) start_cond = 1;
    if(sda==1 && scl==1) stop_cond = 1;
end

//Máquina de estados (item 2.3)
always_comb begin: mudancas_de_estados
    stop = 0; //Saída stop permanece em zero até o momento do pulso
    prox_estado = estado_atual;
    if(~reset) begin
        prox_estado = START;
    end
    else
    case (estado_atual)
        START: begin
            if(start_cond==1 && sobe_scl==1) prox_estado = R0;
        end
        R0: begin
            if(sobe_scl==1) begin
            prox_estado = R1;
            addr_ff[7] = endereco_local[6];
            end
        end
        R1: begin
            if(sobe_scl==1) begin
            prox_estado = R2;
            addr_ff[6] = endereco_local[5];
            end
        end
        R2: begin
            if(sobe_scl==1) begin
            prox_estado = R3;
            addr_ff[5] = endereco_local[4];
            end
        end
        R3: begin
            if(sobe_scl==1) begin
            prox_estado = R4;
            addr_ff[4] = endereco_local[3];
            end
        end
        R4: begin
            if(sobe_scl==1) begin
            prox_estado = R5;
            addr_ff[3] = endereco_local[2];
            end
        end
        R5: begin
            if(sobe_scl==1) begin
            prox_estado = R6;
            addr_ff[2] = endereco_local[1];
            end
        end
        R6: begin
            if(sobe_scl==1) begin
            prox_estado = OPERACAO;
            addr_ff[1] = endereco_local[0];
            end
        end
        OPERACAO: begin
            if(sobe_scl==1) begin
            prox_estado = STOP;
            addr_ff[0] = pronto; //Oitavo bit sendo capturado (item 2.4)
            end
        end
        STOP: begin
            if(stop_cond==1) begin
            prox_estado = START;
            stop = 1; //Pulso em stop durante um ciclo de clock (item 2.6)
            end
        end
    endcase
end

//Pulso na saída escrita, verificação se endereços local e recebido são iguais
always_comb begin
    endereco_recebido = addr_ff[7:1];
    operacao = addr_ff[0]; //Oitavo bit sendo salvo em operação (item 2.4)
    //Escrita recebe nível lógico (item 2.5)
    if(endereco_recebido==endereco_local && operacao==0) escrita = 1;
end
 
endmodule

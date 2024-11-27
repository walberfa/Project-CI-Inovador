`timescale 1ns/10ps

module semaforo2 (
    input logic clk, rst, pulso,
    output logic rua_1_vermelho, rua_1_verde, rua_1_amarelo,
    output logic rua_2_vermelho, rua_2_verde, rua_2_amarelo
);

reg [1:0] prox_estado, estado_atual;

always_ff @( clk ) begin : atualiza_estado
    estado_atual <= prox_estado;
end

always_comb begin : logica_estado
    prox_estado = estado_atual;
    if(rst) prox_estado = 2'b00;
    else 
        case(estado_atual)
        2'b00: if(pulso) prox_estado = 2'b01; //rua 2 muda p amarelo
        2'b01: if(pulso) prox_estado = 2'b10; //rua 1 muda p verde, rua 2 p vermelho
        2'b10: if(pulso) prox_estado = 2'b11; //rua 1 muda p amarelo
        2'b11: if(pulso) prox_estado = 2'b00; //rua 1 muda p vermelho, rua 2 p verde
        endcase 
end

always @(estado_atual) begin
    rua_1_vermelho = 0;
    rua_1_amarelo = 0;
    rua_1_verde = 0;
    rua_2_vermelho = 0;
    rua_2_amarelo = 0;
    rua_2_verde = 0;

    case(estado_atual)
    2'b00: begin
        rua_1_vermelho = 1;
        rua_2_verde = 1;
        end
    2'b01: begin
        rua_1_vermelho = 1;
        rua_2_amarelo = 1;
        end
    2'b10: begin
        rua_1_verde = 1;
        rua_2_vermelho= 1;
        end
    2'b11: begin
        rua_1_amarelo = 1;
        rua_2_vermelho= 1;
        end
    endcase
end

endmodule
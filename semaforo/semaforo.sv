`timescale 1ns/10ps

module semaforo (
    input logic clk, rst, pulso,
    output logic vermelho, verde, amarelo
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
        2'b00: prox_estado = 2'b11; //muda pra vermelho
        2'b01: if(pulso) prox_estado = 2'b10; //muda pra amarelo
        2'b10: if(pulso) prox_estado = 2'b11; //muda pra vermelho
        2'b11: if(pulso) prox_estado = 2'b01; //muda pra verde
        endcase 
    
end

always @(estado_atual) begin
    vermelho = 0;
    amarelo = 0;
    verde = 0;
    case(estado_atual)
    2'b00: begin
        vermelho = 1;
        amarelo = 1;
        end
    2'b01: verde = 1;
    2'b10: amarelo = 1;
    2'b11: vermelho = 1;
    endcase
end

endmodule

`timescale 1ns/10ps

module semaforo_pedestre (
    input logic clk, rst, botao_pedestre,
    output logic Q1, // vermelho veículos
    output logic Q2, // amarelo veículos
    output logic Q3, // verde veículos
    output logic Q4, // vermelho pedestres
    output logic Q5  // veerde pedestres
);

reg [1:0] prox_estado, estado_atual;
reg [3:0] counter, counter_ff;

always_ff @(posedge clk) begin : atualiza_estado
    estado_atual <= prox_estado;
    counter_ff <= counter;
end

always_comb begin : logica_estado
    prox_estado = estado_atual;
    counter = 0;
    if(rst) prox_estado = 2'b00;
    else 
        case(estado_atual)
        2'b00: if(botao_pedestre) prox_estado = 2'b01; //muda pra "amarelo"
        2'b01: begin
            counter = counter_ff + 1;
            if(counter_ff==1) begin
                counter = 0;
                prox_estado = 2'b10; //muda pra "passa pedestre"
            end
        end
        2'b10: begin
            counter = counter_ff + 1;
            if(counter_ff==3) prox_estado = 2'b00; //muda pra "passa veículo"
        end
        endcase 
    
end

always @(estado_atual) begin
    Q1 = 0;
    Q2 = 0;
    Q3 = 0;
    Q4 = 0;
    Q5 = 0;
    case(estado_atual)
    2'b00: begin //passa veículos
        Q3 = 1;
        Q4 = 1;
    end
    2'b01: begin //amarelo
        Q2 = 1;
        Q4 = 1;
    end
    2'b10: begin //passa pedestre
        Q1 = 1;
        Q5 = 1;
    end
    endcase
end


endmodule

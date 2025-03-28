//--------------------------------------------------------
// Square Root
// Walber Florencio
// CI Inovador - Polo UFC
// Verificação Formal e Funcional
//--------------------------------------------------------


module sqrt_int #(parameter WIDTH=8) (
    input  logic                   clk,
    input  logic                   start,
    output logic                   busy,
    output logic                   valid,
    input  logic [WIDTH-1:0]       rad,
    output logic [WIDTH-1:0]       root,
    output logic [WIDTH-1:0]       rem
);

    logic [WIDTH-1:0] x, x_next;
    logic [WIDTH-1:0] q, q_next;
    logic [WIDTH+1:0] ac, ac_next;
    logic [WIDTH+1:0] test_res;
    localparam ITER = WIDTH >> 1;
    logic [$clog2(ITER)-1:0] i;

    always_comb begin
        test_res = ac - {q, 2'b01};
        if (test_res[WIDTH+1] == 0) begin
            ac_next = {test_res[WIDTH-1:0], x, 2'b0};
            x_next = {x[WIDTH-1:0], 2'b0};
            q_next = {q[WIDTH-2:0], 1'b1};
        end else begin
            ac_next = {ac[WIDTH-1:0], x, 2'b0};
            x_next = {x[WIDTH-1:0], 2'b0};
            q_next = q << 1;
        end
    end

    always_ff @(posedge clk) begin
        if (start) begin
            busy <= 1;
            valid <= 0;
            i <= 0;
            q <= 0;
            ac <= {{WIDTH{1'b0}}, rad, 2'b0};
            x <= rad;
        end else if (busy) begin
            if (i == ITER-1) begin
                busy <= 0;
                valid <= 1;
                root <= q_next;
                rem <= ac_next[WIDTH+1:2];
            end else begin
                i <= i + 1;
                x <= x_next;
                ac <= ac_next;
                q <= q_next;
            end
        end
    end

endmodule

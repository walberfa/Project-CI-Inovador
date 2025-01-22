`timescale 1ns/10ps

module control(
    input logic [5:0] op_code, funct_field,
    output logic RegDst, ALUScr, MemtoReg, RegWrite, MemRead, MemWrite, Branch, 
    output logic [1:0] ALUOp,
    output logic [3:0] operation
);

    main_control main_control_inst(
        .op_code(op_code),
        .RegDst(RegDst),
        .ALUScr(ALUScr),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp1(ALUOp[1]),
        .ALUOp0(ALUOp[0])
    );

    ALU_control ALU_control_inst(
        .ALUOp(ALUOp),
        .funct_field(funct_field),
        .operation(operation)
    );

endmodule
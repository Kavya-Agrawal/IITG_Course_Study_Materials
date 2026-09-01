`timescale 1ns / 1ps



module ALU (
    input [31:0] a,
    input [31:0] b,
    input [3:0] op,
    output reg [31:0] result,
    output zero
);
    wire overflow;
    wire [31:0] carry;
    wire [31:0] alu_result;
    wire set;
    wire of;

    wire a_invert = 0;  
    wire b_invert = (final_operation == 4'b0110);  // SUB
    wire cin      = (final_operation == 4'b0110);  // SUB -> carryin = 1 

    reg [3:0] final_operation;

    always @(*) begin
        case (op)
            4'b0111: begin
                result = {31'b0000000000000000000000000000000, set};  
                final_operation = 4'b0110;
            end
            default: begin
                result = alu_result;
                final_operation = op;
            end
        endcase
    end

    // Bit 0 (LSB)
    alu_1bit alu0 (
        .a(a[0]),
        .b(b[0]),
        .a_invert(a_invert),
        .b_invert(b_invert),
        .less(set),  // from MSB set
        .carryin(cin),
        .op(final_operation),
        .result(alu_result[0]),
        .carryout(carry[0])
    );

    // Bits 1 to 30
    genvar i;
    generate
        for (i = 1; i < 31; i = i + 1) begin : alu_loop
            alu_1bit alu_i (
                .a(a[i]),
                .b(b[i]),
                .a_invert(a_invert),
                .b_invert(b_invert),
                .less(1'b0),
                .carryin(carry[i - 1]),
                .op(final_operation),
                .result(alu_result[i]),
                .carryout(carry[i])
            );
        end
    endgenerate

    // Bit 31 (MSB)
    alu_1bit_msb alu31 (
        .a(a[31]),
        .b(b[31]),
        .a_invert(a_invert),
        .b_invert(b_invert),
        .less(1'b0),
        .carryin(carry[30]),
        .op(final_operation),
        .result(alu_result[31]),
        .set(set),
        .overflow(of)
    );

    assign overflow = of;

    wire or0, or1, or2, or3, or4, or5, or6, or7;
    wire or8, or9, or10, or11, or12, or13, or14, or15;
    wire or16, or17, or18, or19, or20, or21, or22, or23;
    wire or24, or25, or26, or27, or28, or29, or30;

    wire or_final_0, or_final_1, or_final_2, or_final_3;
    wire or_final_4, or_final_5, or_final_6, final_or;
    wire is_zero_internal;

    // Pairwise OR (first level)
    or (or0, alu_result[0], alu_result[1]);
    or (or1, alu_result[2], alu_result[3]);
    or (or2, alu_result[4], alu_result[5]);
    or (or3, alu_result[6], alu_result[7]);
    or (or4, alu_result[8], alu_result[9]);
    or (or5, alu_result[10], alu_result[11]);
    or (or6, alu_result[12], alu_result[13]);
    or (or7, alu_result[14], alu_result[15]);
    or (or8, alu_result[16], alu_result[17]);
    or (or9, alu_result[18], alu_result[19]);
    or (or10, alu_result[20], alu_result[21]);
    or (or11, alu_result[22], alu_result[23]);
    or (or12, alu_result[24], alu_result[25]);
    or (or13, alu_result[26], alu_result[27]);
    or (or14, alu_result[28], alu_result[29]);
    or (or15, alu_result[30], alu_result[31]);

    // Second level
    or (or16, or0, or1);
    or (or17, or2, or3);
    or (or18, or4, or5);
    or (or19, or6, or7);
    or (or20, or8, or9);
    or (or21, or10, or11);
    or (or22, or12, or13);
    or (or23, or14, or15);

    // Third level
    or (or24, or16, or17);
    or (or25, or18, or19);
    or (or26, or20, or21);
    or (or27, or22, or23);

    // Fourth level
    or (or28, or24, or25);
    or (or29, or26, or27);

    // Final OR
    or (final_or, or28, or29);

    // NOT of final OR → zero
    not (zero, final_or);

endmodule


module alu_1bit (
    input a,
    input b,
    input a_invert,
    input b_invert,
    input less,
    input carryin,
    input [3:0] op,
    output result,
    output carryout
);
    wire nota, notb;
    wire a_input, b_input;

    // Invert a and b
    not (nota, a);
    not (notb, b);

    // Choose inverted or normal input
    mux2to1_mux mux_a (.i0(a), .i1(nota), .sel(a_invert), .out(a_input));
    mux2to1_mux mux_b (.i0(b), .i1(notb), .sel(b_invert), .out(b_input));

    // Logic gates
    wire and_out, or_out, nor_out;
    and (and_out, a_input, b_input);
    or  (or_out, a_input, b_input);
    not (nor_out, or_out);

    // Full adder
    wire sum;
    full_adder_1bit adder (
        .a(a_input),
        .b(b_input),
        .cin(carryin),
        .sum(sum),
        .cout(carryout)
    );

    // Generate 16 possible outputs
    wire [15:0] alu_outputs;
    assign alu_outputs[0]  = and_out;   // 0000 - AND
    assign alu_outputs[1]  = or_out;    // 0001 - OR
    assign alu_outputs[2]  = sum;       // 0010 - ADD
    assign alu_outputs[3]  = 1'b0;      // 0011 - unused
    assign alu_outputs[4]  = 1'b0;      // 0100 - unused
    assign alu_outputs[5]  = 1'b0;      // 0101 - unused
    assign alu_outputs[6]  = sum;       // 0110 - SUB (a - b using b_invert=1 and carryin=1)
    assign alu_outputs[7]  = less;      // 0111 - SET LESS THAN
    assign alu_outputs[8]  = 1'b0;      // 1000 - unused
    assign alu_outputs[9]  = 1'b0;      // 1001 - unused
    assign alu_outputs[10] = 1'b0;      // 1010 - unused
    assign alu_outputs[11] = 1'b0;      // 1011 - unused
    assign alu_outputs[12] = nor_out;   // 1100 - NOR
    assign alu_outputs[13] = 1'b0;      // 1101 - unused
    assign alu_outputs[14] = 1'b0;      // 1110 - unused
    assign alu_outputs[15] = 1'b0;      // 1111 - unused

    // 16-to-1 MUX
    mux16to1 result_mux (
        .inputs(alu_outputs),
        .sel(op),
        .out(result)
    );

endmodule


module alu_1bit_msb (
    input a,
    input b,
    input a_invert,
    input b_invert,
    input less,          // not used in MSB, but keep for uniformity
    input carryin,
    input [3:0] op,
    output result,
    output overflow,
    output set
);
    wire nota, notb;
    wire a_input, b_input;
    wire carryout;

    // Invert a and b
    not (nota, a);
    not (notb, b);

    // Choose inverted or normal input
    mux2to1_mux mux_a (.i0(a), .i1(nota), .sel(a_invert), .out(a_input));
    mux2to1_mux mux_b (.i0(b), .i1(notb), .sel(b_invert), .out(b_input));

    // Logic gates
    wire and_out, or_out, nor_out;
    and (and_out, a_input, b_input);
    or  (or_out, a_input, b_input);
    not (nor_out, or_out);

    // Full adder for MSB
    wire sum;
    full_adder_1bit adder (
        .a(a_input),
        .b(b_input),
        .cin(carryin),
        .sum(sum),
        .cout(carryout)
    );

    assign set = sum; 
    xor (overflow, carryin, carryout);

    // 16 possible outputs
    wire [15:0] alu_outputs;
    assign alu_outputs[0]  = and_out;   // AND
    assign alu_outputs[1]  = or_out;    // OR
    assign alu_outputs[2]  = sum;       // ADD
    assign alu_outputs[3]  = 1'b0;
    assign alu_outputs[4]  = 1'b0;
    assign alu_outputs[5]  = 1'b0;
    assign alu_outputs[6]  = sum;       // SUB
    assign alu_outputs[7]  = less;      // SLT (input from LSB comparator)
    assign alu_outputs[8]  = 1'b0;
    assign alu_outputs[9]  = 1'b0;
    assign alu_outputs[10] = 1'b0;
    assign alu_outputs[11] = 1'b0;
    assign alu_outputs[12] = nor_out;   // NOR
    assign alu_outputs[13] = 1'b0;
    assign alu_outputs[14] = 1'b0;
    assign alu_outputs[15] = 1'b0;

    // 16-to-1 mux for final result
    mux16to1 result_mux (
        .inputs(alu_outputs),
        .sel(op),
        .out(result)
    );

endmodule

module tb_signel_cycle_mips();
  reg clk;
  reg reset;
  signel_cycle_mips uut (.reset(reset), .clk(clk));
  always #5 clk = ~clk;

  // Clock and Reset Initialization
  initial begin
    clk = 0;
    reset = 1;
    $display("=== Simulation Started ===");

    // Display initial memory state
    $display("\n--- Initial Data Memory Contents ---");
    for (integer j = 0; j < 16; j = j + 1) begin
      $display("Mem[%2d] = %0d", j, uut.datapath.Data_Memory.memory[j]);
    end

    #20 reset = 0;

    $display("\nTime(ns) | Operation  | Address/Reg | Value");
    $display("---------------------------------------------");

    // Monitor Reg and Mem writes
    forever begin
      @(posedge clk) begin
        if (uut.RegWrite) begin
          $display("%8t | REG WRITE | R%-2d         | %0d", 
                   $time, uut.datapath.write_reg_final, 
                   uut.datapath.write_data);
        end

        if (uut.MemWrite) begin
          $display("%8t | MEM WRITE | Addr %0d     | %0d", 
                   $time, uut.datapath.ALU_result, 
                   uut.datapath.reg_read_data2);
        end
      end
    end
  end

  // Simulation End
  initial begin
    #920;
    $display("\n=== Final State ===");

    $display("\n--- Register File Contents (Non-zero only) ---");
    // for (integer i = 0; i < 32; i = i + 1) begin
    //   if (uut.datapath.Registers.regs[i].r.q !== 0) begin
    //     $display("R%-2d = %0d", i, uut.datapath.Registers.regs[i].r.q);
    //   end
    // end

    $display("\n--- Final Data Memory Contents ---");
    for (integer j = 0; j < 16; j = j + 1) begin
      $display("Mem[%2d] = %0d", j, uut.datapath.Data_Memory.memory[j]);
    end

    $display("\n=== Simulation Completed ===");
    $finish;
  end
endmodule


module data_mem #(parameter L = 256)(clk,address,read_data, write_data, read_en, write_en);
  
  // Synchronous memory module with 256 32-bit locations

  parameter S=32; // Width of each memory word is 32 bits

  // Input/Output declarations
  input [$clog2(L) - 1:0] address;   // Memory address (log2(L) bits wide)
  input [S-1:0] write_data;          // Data to be written to memory
  input clk;                         // Clock signal
  input write_en;                    // Write enable signal
  input read_en;                     // Read enable signal
  output [(S-1):0] read_data;        // Data read from memory

  // Memory array of size L, each entry S bits wide
  reg [S-1:0] memory [L-1:0];

  // Continuous assignment to read data (word-aligned using address/4)
  assign read_data=memory[address/4];
    
  // Write operation: occurs on positive edge of clock when write_en is high
  always @(posedge clk) begin
    if (write_en==1) begin
        memory[address/4]<=write_data;
    end
  end

  // The current program doesn't require initializing memory from a file
  // initial $readmemh("memdata.dat", memory);

endmodule


module reg_file (
  input         clk,
  input         reset,
  input         write_en,
  input  [4:0]  read_reg1,
  input  [4:0]  read_reg2,
  input  [4:0]  write_reg,
  input  [31:0] write_data,
  output [31:0] read_data1,
  output [31:0] read_data2
);
  // Internal wires renamed for uniqueness and clarity
  wire [31:0]        write_enable_decoded_bus; 
  wire [1023:0]      all_registers_concatenated_bus; // 32×32-bit wide

  // One-hot decoder for write register
  DECODER_5_TO_32 dec (
    .in  (write_reg),
    .en  (write_en),
    .out (write_enable_decoded_bus)
  );

  // 32× register32 instances, each hooked to a 32‑bit slice
  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1) begin : regs
      register32 r (
        .clk     (clk),
        .reset   (reset),
        .write_en(write_enable_decoded_bus[i]),
        .d       (write_data),
        .q       (all_registers_concatenated_bus[i*32 +: 32])
      );
    end
  endgenerate

  // Two read ports using the flattened bus
  mux32_1 m1 (
    .in_flat(all_registers_concatenated_bus),
    .sel    (read_reg1),
    .out    (read_data1)
  );
  mux32_1 m2 (
    .in_flat(all_registers_concatenated_bus),
    .sel    (read_reg2),
    .out    (read_data2)
  );
endmodule

module PC (
  input clk,                  // Clock signal
  input reset,                // Active-high synchronous reset
  input en,                   // Enable signal for updating PC
  input [31:0] d,             // Input data (next PC value)
  output reg [31:0] q         // Output data (current PC value)
);

  // Internal wire to hold either the new input or the retained PC value
  wire [31:0] pc_next;

  // Enable-based selection: update with new data if 'en' is high, else retain current value
  assign pc_next = en ? d : q;

  // Synchronous reset and PC update on rising clock edge
  always @(posedge clk) begin
    if (reset)
      q <= 32'b0;             // Reset PC to 0
    else
      q <= pc_next;           // Update PC based on enable signal
  end

endmodule

// DATAPATH MODULE FOR MIPS PROCESSOR
module DATAPATH_MIPS(
  input clk,
  input reset,
  
  // Control signals from controller
  input RegDst,         
  input Jump,           
  input Branch,         
  input MemRead,        
  input MemToReg,       
  input MemWrite,       
  input ALUSrc,         
  input RegWrite,       
  input Link,           
  input JR,             
  input PC_en,          
  
  // ALU control
  input [3:0] ALU_opcode,
  
  // Outputs to controller and ALU control
  output wire [5:0] OpCode,
  output wire [5:0] funct
);

  // Instruction memory and fetch
  wire [31:0] PC_out, instr_out;
  INSTRUCTION_MEMORY_MODULE Intruction_Memory(.read_address(PC_out), .instruction(instr_out));
  assign OpCode = instr_out[31:26];

  // Decode instruction fields
  wire [4:0] rs = instr_out[25:21];
  wire [4:0] rt = instr_out[20:16];
  wire [4:0] rd = instr_out[15:11];
  wire [15:0] immediate = instr_out[15:0];
  wire [25:0] jump_target = instr_out[25:0];
  assign funct = instr_out[5:0];

  // Program counter and PC+4 calculation
  wire [31:0] PC_plus4, PC_next;
  wire ALU_zero;
  PC Program_Counter(.clk(clk), .reset(reset), .en(PC_en), .d(PC_next), .q(PC_out));
  adder PC_plus4_adder(.a(PC_out), .b(32'd4), .y(PC_plus4));

  // Jump address calculation
  wire [28:0] jump_target_shifted;
  SHIFT_LEFT_LOGICAL_PAD #(.INP_WIDTH(26)) Shift_Jump_2(.in(jump_target), .out(jump_target_shifted));
  wire [31:0] jump_addr = {PC_plus4[31:28], jump_target_shifted};

  // Branch address calculation
  wire [31:0] sign_ext_imm;
  SIGN_EXTEND_MODULE Sign_Extender(.in(immediate), .out(sign_ext_imm));
  wire [31:0] shifted_imm;
  SHIFT_LEFT_LOGICAL Shift_Imm_2(.in(sign_ext_imm), .out(shifted_imm));
  wire [31:0] branch_addr;
  adder Branch_Adder(.a(PC_plus4), .b(shifted_imm), .y(branch_addr));

  // Branch decision and mux
  wire branch_taken = Branch & ALU_zero;
  wire [31:0] PC_branch_mux_out;
  mux2to1 #(.WIDTH(32)) PC_branch_mux(
    .in0(PC_plus4),
    .in1(branch_addr),
    .sel(branch_taken),
    .out(PC_branch_mux_out)
  );

  // Jump decision and mux
  wire [31:0] PC_jump_mux_out;
  mux2to1 #(.WIDTH(32)) PC_jump_mux(
    .in0(PC_branch_mux_out),
    .in1(jump_addr),
    .sel(Jump),
    .out(PC_jump_mux_out)
  );

  // JR instruction handling (jump to register)
  wire [31:0] reg_read_data1;
  mux2to1 #(.WIDTH(32)) PC_Jump_Reg(
    .in0(PC_jump_mux_out),
    .in1(reg_read_data1),
    .sel(JR),
    .out(PC_next)
  );

  // Register file logic
  wire [4:0] write_reg_intermediate, write_reg_final;
  wire [31:0] write_data;
  wire [31:0] reg_read_data2;

  // Destination register selection (R-type vs I-type)
  mux2to1 #(.WIDTH(5)) write_reg_mux(
    .in0(rt), 
    .in1(rd), 
    .sel(RegDst), 
    .out(write_reg_intermediate)
  );

  // Link register decision for jal instruction
  mux2to1 #(.WIDTH(5)) link_reg_mux(
    .in0(write_reg_intermediate), 
    .in1(5'd31), 
    .sel(Link), 
    .out(write_reg_final)
  );

  // Register file instantiation
  reg_file Registers(
    .clk(clk),
    .reset(reset),
    .write_en(RegWrite),
    .read_reg1(rs),
    .read_reg2(rt),
    .write_reg(write_reg_final),
    .write_data(write_data),
    .read_data1(reg_read_data1),
    .read_data2(reg_read_data2)
  );

  // ALU input multiplexing
  wire [31:0] ALU_in2;
  wire [31:0] ALU_result;

  // ALU operand 2 selection (reg or immediate)
  mux2to1 #(.WIDTH(32)) ALU_src_mux(
    .in0(reg_read_data2),
    .in1(sign_ext_imm),
    .sel(ALUSrc),
    .out(ALU_in2)
  );

  // ALU instantiation
  ALU Arithmetic_Logic_Unit(
    .a(reg_read_data1),
    .b(ALU_in2),
    .op(ALU_opcode),
    .result(ALU_result),
    .zero(ALU_zero)
  );

  // Data memory access
  wire [31:0] mem_read_data;
  data_mem Data_Memory(
    .clk(clk),
    .write_en(MemWrite),
    .read_en(MemRead),
    .address(ALU_result),
    .write_data(reg_read_data2),
    .read_data(mem_read_data)
  );

  // Write-back stage
  wire [31:0] wb_data;
  mux2to1 #(.WIDTH(32)) wb_mux(
    .in0(ALU_result),
    .in1(mem_read_data),
    .sel(MemToReg),
    .out(wb_data)
  );

  // Link data mux to write PC+4 for jal instruction
  mux2to1 #(.WIDTH(32)) link_data_mux(
    .in0(wb_data),
    .in1(PC_plus4),
    .sel(Link),
    .out(write_data)
  );

endmodule


module signel_cycle_mips(
  input reset,         // Reset signal to initialize the processor
  input clk            // Clock signal to synchronize operations
);

  wire [5:0] OpCode, funct;     // Fields from instruction: OpCode and function code
  wire [3:0] ALU_opcode;        // ALU operation code determined by ALU control unit
  wire [1:0] ALUOp;             // ALU operation type determined by main control unit
  wire RegDst;                  // Register destination selector for register write
  wire Jump;                    // Jump control signal
  wire Branch;                  // Branch control signal
  wire MemRead;                 // Memory read enable
  wire MemToReg;                // Select signal for register write data source
  wire MemWrite;                // Memory write enable
  wire ALUSrc;                  // ALU source selector (register or immediate)
  wire RegWrite;                // Register file write enable
  wire Link;                    // Link control signal for JAL instruction
  wire JR;                      // Jump Register control signal
  wire PC_en;                   // Program Counter enable signal 

  DATAPATH_MIPS datapath (
    .clk(clk),                  // Clock signal
    .reset(reset),              // Reset signal
    .RegDst(RegDst),            // Register destination signal
    .Jump(Jump),                // Jump signal
    .Branch(Branch),            // Branch signal
    .MemRead(MemRead),          // Memory read enable
    .MemToReg(MemToReg),        // Memory to register signal
    .MemWrite(MemWrite),        // Memory write enable
    .ALUSrc(ALUSrc),            // ALU source signal
    .RegWrite(RegWrite),        // Register write enable
    .Link(Link),                // Link signal
    .JR(JR),                    // Jump Register signal
    .PC_en(PC_en),              // Program Counter enable
    .ALU_opcode(ALU_opcode),    // ALU opcode signal
    .OpCode(OpCode),            // OpCode from instruction
    .funct(funct)               // funct field from instruction
  );

  CONTROLLER_MIPS ctrl (
    .clk(clk),                  // Clock signal
    .reset(reset),              // Reset signal
    .OpCode(OpCode),            // OpCode from instruction
    .RegDst(RegDst),            // Register destination control
    .Jump(Jump),                // Jump control
    .Branch(Branch),            // Branch control
    .MemRead(MemRead),          // Memory read enable
    .MemToReg(MemToReg),        // Memory to register control
    .MemWrite(MemWrite),        // Memory write enable
    .ALUSrc(ALUSrc),            // ALU source control
    .RegWrite(RegWrite),        // Register write enable
    .Link(Link),                // Link control
    .PC_en(PC_en),              // Program Counter enable
    .JR(JR),                    // Jump Register control
    .ALUOp(ALUOp)               // ALU operation type
  );

  ALU_CONTROL_MIPS alu_ctrl (
    .funct(funct),              // funct field from instruction (R-type)
    .ALUOp(ALUOp),              // ALU operation type from controller
    .ALU_opcode(ALU_opcode)     // Specific ALU opcode generated
  );

endmodule

module CONTROLLER_MIPS(
    input clk,
    input reset,
    input [5:0] OpCode,

    output RegDst,
    output Jump,
    output Branch,
    output MemRead,
    output MemToReg,
    output MemWrite,
    output ALUSrc,
    output RegWrite,
    output Link,
    output PC_en,
    output JR,
    output [1:0] ALUOp
);
    // Instruction type detection using renamed internal wires
    wire is_instruction_rtype;
    wire is_instruction_lw;
    wire is_instruction_sw;
    wire is_instruction_beq;
    wire is_instruction_jump;
    wire is_instruction_jal;
    wire is_instruction_jr;
    wire is_instruction_addi;

    // One-hot encoding for opcode types
    assign is_instruction_rtype = (OpCode == 6'b000000);
    assign is_instruction_lw    = (OpCode == 6'b100011);
    assign is_instruction_sw    = (OpCode == 6'b101011);
    assign is_instruction_beq   = (OpCode == 6'b000100);
    assign is_instruction_jump  = (OpCode == 6'b000010);
    assign is_instruction_jal   = (OpCode == 6'b000011);
    assign is_instruction_jr    = (OpCode == 6'b000101);  // Assuming 000101 is used for JR
    assign is_instruction_addi  = (OpCode == 6'b001000);

    // Control signal generation (13 bits)
    assign {RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch,
            ALUOp[1:0], Jump, Link, JR, PC_en} =

        is_instruction_rtype ? 13'b100_1000_10_0001 : // R-type
        is_instruction_lw    ? 13'b011_1100_00_0001 : // LW
        is_instruction_sw    ? 13'b010_0010_00_0001 : // SW
        is_instruction_beq   ? 13'b000_0001_01_0001 : // BEQ
        is_instruction_jump  ? 13'b000_0000_00_1001 : // JUMP
        is_instruction_jal   ? 13'b000_1000_00_1101 : // JAL
        is_instruction_addi  ? 13'b010_1000_00_0001 : // ADDI
        is_instruction_jr    ? 13'b000_0000_00_0011 : // JR
                               13'b000_0000_11_0000 ; // default (NOP)

endmodule

module ALU_CONTROL_MIPS(
    // from datapath
    input [5:0] funct,
    // from main controller
    input [1:0] ALUOp,
    // to ALU
    output [3:0] ALU_opcode
);
    // Internal wires renamed
    wire signal_is_add_operation;
    wire signal_is_sub_operation;
    wire signal_is_and_operation;
    wire signal_is_or_operation;
    wire signal_is_slt_operation;

    // One-hot detection logic for ALU control
    assign signal_is_add_operation = ((ALUOp == 2'b00) || ((ALUOp == 2'b10) && (funct == 6'b100000))); 
	assign signal_is_sub_operation = ((ALUOp == 2'b01) || ((ALUOp == 2'b10) && (funct == 6'b100010))); 
	assign signal_is_and_operation = ((ALUOp == 2'b10) && (funct == 6'b100100));
	assign signal_is_or_operation  = ((ALUOp == 2'b10) && (funct == 6'b100101));
	assign signal_is_slt_operation = ((ALUOp == 2'b10) && (funct == 6'b101010));

    // ALU opcode output selection
    assign ALU_opcode = signal_is_add_operation ? 4'b0010 : // add
                        signal_is_sub_operation ? 4'b0110 : // sub
                        signal_is_and_operation ? 4'b0000 : // and
                        signal_is_or_operation  ? 4'b0001 : // or
                        signal_is_slt_operation ? 4'b0111 : // slt
                                                  4'b1111;  // default: no operation

endmodule


module mux16to1 (
    input [15:0] inputs,  // 16-bit input
    input [3:0] sel,      // 4-bit select line
    output out            // MUX output
);
    wire [15:0] and_out;  // Intermediate wires for AND gates
    wire [3:0] not_sel;   // Inverted select lines

    // Generate the inverted select lines (NOT gates)
    not (not_sel[0], sel[0]);
    not (not_sel[1], sel[1]);
    not (not_sel[2], sel[2]);
    not (not_sel[3], sel[3]);

    // AND gates to select the appropriate input
    and (and_out[0], inputs[0], not_sel[3], not_sel[2], not_sel[1], not_sel[0]);
    and (and_out[1], inputs[1], not_sel[3], not_sel[2], not_sel[1], sel[0]);
    and (and_out[2], inputs[2], not_sel[3], not_sel[2], sel[1], not_sel[0]);
    and (and_out[3], inputs[3], not_sel[3], not_sel[2], sel[1], sel[0]);
    and (and_out[4], inputs[4], not_sel[3], sel[2], not_sel[1], not_sel[0]);
    and (and_out[5], inputs[5], not_sel[3], sel[2], not_sel[1], sel[0]);
    and (and_out[6], inputs[6], not_sel[3], sel[2], sel[1], not_sel[0]);
    and (and_out[7], inputs[7], not_sel[3], sel[2], sel[1], sel[0]);
    and (and_out[8], inputs[8], sel[3], not_sel[2], not_sel[1], not_sel[0]);
    and (and_out[9], inputs[9], sel[3], not_sel[2], not_sel[1], sel[0]);
    and (and_out[10], inputs[10], sel[3], not_sel[2], sel[1], not_sel[0]);
    and (and_out[11], inputs[11], sel[3], not_sel[2], sel[1], sel[0]);
    and (and_out[12], inputs[12], sel[3], sel[2], not_sel[1], not_sel[0]);
    and (and_out[13], inputs[13], sel[3], sel[2], not_sel[1], sel[0]);
    and (and_out[14], inputs[14], sel[3], sel[2], sel[1], not_sel[0]);
    and (and_out[15], inputs[15], sel[3], sel[2], sel[1], sel[0]);

    // OR gate to select the final output
    or (out, and_out[0], and_out[1], and_out[2], and_out[3], and_out[4], and_out[5], 
        and_out[6], and_out[7], and_out[8], and_out[9], and_out[10], and_out[11], 
        and_out[12], and_out[13], and_out[14], and_out[15]);

endmodule



module mux2to1_mux (
    input i0,
    input i1,
    input sel,
    output out
);
    wire not_sel, a1, a2;
    not (not_sel, sel);
    and (a1, i0, not_sel);
    and (a2, i1, sel);
    or  (out, a1, a2);
endmodule


module full_adder_1bit (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);
    wire axb, axb_cin, ab, bc, ac;

    xor (axb, a, b);
    xor (sum, axb, cin);

    and (ab, a, b);
    and (bc, b, cin);
    and (ac, a, cin);
    or  (cout, ab, bc, ac);
endmodule





module INSTRUCTION_MEMORY_MODULE #(parameter Addr_width = 8) (
  input  [$clog2(1 << Addr_width) - 1:0] read_address,  // Address input
  output [31:0] instruction                         // 32-bit instruction output
);

  // Parameters
  parameter DATA_WIDTH = 32;
  parameter DEPTH = (1 << Addr_width);  // Number of memory locations

  // Internal memory array: 256 locations of 32-bit instructions
  reg [DATA_WIDTH-1:0] instr_mem_array [0:DEPTH-1];

  // Asynchronous read (word-addressable, divide by 4)
  assign instruction = instr_mem_array[read_address >> 2];

// ----------------------------
// ----------------------------
// ----------->> FUNTION 1 Store 5 nums in Memory and then calculate Sum | Also involves funtion call and jal jr beq etc. all instructions<<<<<<<----------------------------------
// ----------------------------
// ----------------------------

  initial begin
    // Main function
    instr_mem_array[0]  = 32'h20080004; // addi $t0, $zero, 4
    instr_mem_array[1]  = 32'h20090014; // addi $t1, $zero, 20
    instr_mem_array[2]  = 32'h00005020; // add  $t2, $zero, $zero
    instr_mem_array[3]  = 32'h200B0005; // addi $t3, $zero, 5

    // store_loop:
    instr_mem_array[4]  = 32'hAD090000; // sw $t1, 0($t0)
    instr_mem_array[5]  = 32'h21080004; // addi $t0, $t0, 4
    instr_mem_array[6]  = 32'h214A0001; // addi $t2, $t2, 1
    instr_mem_array[7]  = 32'h014B702A; // slt $t6, $t2, $t3
    instr_mem_array[8]  = 32'h11C00001; // beq $t6, $zero, store_done
    instr_mem_array[9]  = 32'h08000004; // j store_loop

    // store_done:
    instr_mem_array[10] = 32'h20040004; // addi $a0, $zero, 4
    instr_mem_array[11] = 32'h200B0005; // addi $a1, $zero, 5
    instr_mem_array[12] = 32'h0C00000F; // jal sum_array

    // After function call
    instr_mem_array[13] = 32'hAC020004; // sw $v0, 4($zero)
    instr_mem_array[14] = 32'hFC000000; // custom exit instruction

    // sum_array:
    instr_mem_array[15] = 32'h00044020; // add $t0, $zero, $a0
    instr_mem_array[16] = 32'h000B4820; // add $t1, $zero, $a1
    instr_mem_array[17] = 32'h00005020; // add $t2, $zero, $zero
    instr_mem_array[18] = 32'h00005820; // add $t3, $zero, $zero

    // sum_loop:
    instr_mem_array[19] = 32'h8D0F0000; // lw $t7, 0($t0)
    instr_mem_array[20] = 32'h014F5020; // add $t2, $t2, $t7
    instr_mem_array[21] = 32'h21080004; // addi $t0, $t0, 4
    instr_mem_array[22] = 32'h216B0001; // addi $t3, $t3, 1
    instr_mem_array[23] = 32'h0169602A; // slt $t4, $t3, $t1
    instr_mem_array[24] = 32'h11800001; // beq $t4, $zero, sum_done
    instr_mem_array[25] = 32'h08000013; // j sum_loop

    // sum_done:
    instr_mem_array[26] = 32'h01401020; // add $v0, $t2, $zero
    instr_mem_array[27] = 32'h17E00008; // jr $ra (custom behavior)
  end

// ----------------------------
// ----------------------------
// ----------->> FUNTION 2 Calculate sum of Numbers from 1 to 10 <<<<<<<----------------------------------
// ----------------------------
// ----------------------------
  
  //   initial begin
  //   // Initialize registers
  //   instr_mem_array[0]  = 32'h20080001; // addi $t0, $zero, 1   
  //   instr_mem_array[1]  = 32'h2009000A; // addi $t1, $zero, 10  
  //   instr_mem_array[2]  = 32'h00005020; // add  $t2, $zero, $zero 

  //   // sum_loop:
  //   instr_mem_array[3]  = 32'h01485020; // add  $t2, $t2, $t0    
  //   instr_mem_array[4]  = 32'hAC0A0000; // sw   $t2, 0($zero)   
  //   instr_mem_array[5]  = 32'h21080001; // addi $t0, $t0, 1     
  //   instr_mem_array[6]  = 32'h0109602A; // slt  $t4, $t0, $t1   
  //   instr_mem_array[7]  = 32'h11800001; // beq  $t4, $zero, done 
  //   instr_mem_array[8]  = 32'h08000003; // j    sum_loop         

  //   // done:
  //   instr_mem_array[9]  = 32'h0109602A; // slt  $t4, $t0, $t1   
  //   instr_mem_array[10] = 32'h11000001; // beq  $t0, $t1, skip  
  //   instr_mem_array[11] = 32'h01485020; // add  $t2, $t2, $t0   
  //   instr_mem_array[12] = 32'hAC0A0000; // sw   $t2, 0($zero)  

  //   // skip: (Infinite loop to prevent restart)
  //   instr_mem_array[13] = 32'h0800000D; // j    skip           
  //   instr_mem_array[14] = 32'h00000000; // nop                  
  // end

endmodule

module mux2to1 #(parameter WIDTH = 32) (
  input [WIDTH-1:0] in0,
  input [WIDTH-1:0] in1,
  input sel,
  output [WIDTH-1:0] out
);

  wire sel_neg;
  not(sel_neg, sel);
  
  genvar j;
  generate
    for(j = 0; j < WIDTH; j = j + 1) begin: mux_logic
      wire and0_out, and1_out;
      
      // Replacing '&' with 'and' gate
      and(and0_out, in0[j], sel_neg);  // and0_out = in0[j] AND NOT(sel)
      and(and1_out, in1[j], sel);      // and1_out = in1[j] AND sel
      
      // Replacing '|' with 'or' gate
      or(out[j], and0_out, and1_out);  // out[j] = and0_out OR and1_out
    end
  endgenerate
endmodule


module adder (
  input [31:0] a,
  input [31:0] b,
  output [31:0] y
);
  wire [31:0] carry;
  
  // First bit addition (using half adder)
  wire ha_and_out;
  xor(y[0], a[0], b[0]);
  and(carry[0], a[0], b[0]);
  
  // Remaining bits (using full adders)
  genvar i;
  generate
    for(i=1; i<32; i=i+1) begin: full_adder_chain
      wire xor1_out, and1_out, and2_out, and3_out;
      
      // Sum calculation
      xor(xor1_out, a[i], b[i]);
      xor(y[i], xor1_out, carry[i-1]);
      
      // Carry calculation
      and(and1_out, a[i], b[i]);
      and(and2_out, a[i], carry[i-1]);
      and(and3_out, b[i], carry[i-1]);
      or(carry[i], and1_out, and2_out, and3_out);
    end
  endgenerate
endmodule


module mux2 (
  input  sel,
  input  in0,
  input  in1,
  output out
);
  assign out = sel ? in1 : in0;
endmodule

module dff (
  input  clk,
  input  reset,  // active‑high synchronous reset
  input  d,      
  output q
);
  wire d_int;       // data after reset‑mux
  wire inv_clk;     // inverted clock
  wire master_q;    // master‑latch output
  wire slave_q;     // slave‑latch output
  mux2 reset_mux (
    .sel  (reset),
    .in0  (d),
    .in1  (1'b0),
    .out  (d_int)
  );
  not inv1 (inv_clk, clk);
  mux2 master_mux (
    .sel  (inv_clk),
    .in0  (master_q),
    .in1  (d_int),
    .out  (master_q)
  );
  mux2 slave_mux (
    .sel  (clk),
    .in0  (slave_q),
    .in1  (master_q),
    .out  (slave_q)
  );
  assign q = slave_q;
endmodule


module DECODER_5_TO_32 (
  input [4:0] in,
  input en,
  output [31:0] out
);

  wire n0, n1, n2, n3, n4;

  not (n0, in[0]);
  not (n1, in[1]);
  not (n2, in[2]);
  not (n3, in[3]);
  not (n4, in[4]);

  // Generate all 32 output lines
  // Each output is enabled only if 'en' is high AND input matches exact bit pattern
  and (out[0],  en, n4, n3, n2, n1, n0);  // 00000
  and (out[1],  en, n4, n3, n2, n1,  in[0]);  // 00001
  and (out[2],  en, n4, n3, n2,  in[1], n0);  // 00010
  and (out[3],  en, n4, n3, n2,  in[1],  in[0]);  // 00011
  and (out[4],  en, n4, n3,  in[2], n1, n0);  // 00100
  and (out[5],  en, n4, n3,  in[2], n1,  in[0]);  // 00101
  and (out[6],  en, n4, n3,  in[2],  in[1], n0);  // 00110
  and (out[7],  en, n4, n3,  in[2],  in[1],  in[0]);  // 00111
  and (out[8],  en, n4,  in[3], n2, n1, n0);  // 01000
  and (out[9],  en, n4,  in[3], n2, n1,  in[0]);  // 01001
  and (out[10], en, n4,  in[3], n2,  in[1], n0);  // 01010
  and (out[11], en, n4,  in[3], n2,  in[1],  in[0]);  // 01011
  and (out[12], en, n4,  in[3],  in[2], n1, n0);  // 01100
  and (out[13], en, n4,  in[3],  in[2], n1,  in[0]);  // 01101
  and (out[14], en, n4,  in[3],  in[2],  in[1], n0);  // 01110
  and (out[15], en, n4,  in[3],  in[2],  in[1],  in[0]);  // 01111
  and (out[16], en,  in[4], n3, n2, n1, n0);  // 10000
  and (out[17], en,  in[4], n3, n2, n1,  in[0]);  // 10001
  and (out[18], en,  in[4], n3, n2,  in[1], n0);  // 10010
  and (out[19], en,  in[4], n3, n2,  in[1],  in[0]);  // 10011
  and (out[20], en,  in[4], n3,  in[2], n1, n0);  // 10100
  and (out[21], en,  in[4], n3,  in[2], n1,  in[0]);  // 10101
  and (out[22], en,  in[4], n3,  in[2],  in[1], n0);  // 10110
  and (out[23], en,  in[4], n3,  in[2],  in[1],  in[0]);  // 10111
  and (out[24], en,  in[4],  in[3], n2, n1, n0);  // 11000
  and (out[25], en,  in[4],  in[3], n2, n1,  in[0]);  // 11001
  and (out[26], en,  in[4],  in[3], n2,  in[1], n0);  // 11010
  and (out[27], en,  in[4],  in[3], n2,  in[1],  in[0]);  // 11011
  and (out[28], en,  in[4],  in[3],  in[2], n1, n0);  // 11100
  and (out[29], en,  in[4],  in[3],  in[2], n1,  in[0]);  // 11101
  and (out[30], en,  in[4],  in[3],  in[2],  in[1], n0);  // 11110
  and (out[31], en,  in[4],  in[3],  in[2],  in[1],  in[0]);  // 11111

endmodule


module mux32_1 (
  input  [1023:0] in_flat,   
  input  [4:0]    sel,
  output [31:0]   out
);
  // Extract the 32‑bit word at index sel
  assign out = in_flat[ sel*32 +: 32 ];
endmodule

module register32 (
  input clk,
  input reset,
  input write_en,
  input [31:0] d,
  output [31:0] q
);
  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1) begin : reg_loop
      dff dff_inst (
        .clk(clk),
        .reset(reset),
        .d(write_en ? d[i] : q[i]),
        .q(q[i])
      );
    end
  endgenerate
endmodule

module SIGN_EXTEND_MODULE (
  input [15:0] in,
  output [31:0] out
);
  
  assign out = {{16{in[15]}}, in};
  
endmodule

module SHIFT_LEFT_LOGICAL (
  input [31:0] in,
  output [31:0] out
);
  
  assign out = {in[29:0], 2'b00};
  
endmodule


module SHIFT_LEFT_LOGICAL_PAD #(parameter INP_WIDTH=26) (
  input [INP_WIDTH-1:0] in,
  output [INP_WIDTH+1:0] out
);
  
  assign out = {in, 2'b00};
  
endmodule

module mux5to1 (
  input [31:0] in0,      // AND result (000)
  input [31:0] in1,      // OR result (001)
  input [31:0] in2,      // ADD/SUB result (010/110)
  input [31:0] in3,      // SLT result (111)
  input [31:0] in4,      // NOR result (1100)
  input [3:0] sel,       // ALU control
  output [31:0] out      // Final selected output
);

  wire nsel0, nsel1, nsel2, nsel3;

  // Invert all sel bits for easier use
  not (nsel0, sel[0]);
  not (nsel1, sel[1]);
  not (nsel2, sel[2]);
  not (nsel3, sel[3]);

  wire sel_and, sel_or, sel_add, sel_sub, sel_slt, sel_nor;

  // Control logic using basic gates
  and (sel_and, nsel3, nsel2, nsel1, nsel0);             // 0000
  and (sel_or,  nsel3, nsel2, nsel1, sel[0]);            // 0001
  and (sel_add, nsel3, nsel2, sel[1], nsel0);            // 0010
  and (sel_sub, nsel3, sel[2], sel[1], nsel0);           // 0110
  and (sel_slt, nsel3, sel[2], sel[1], sel[0]);          // 0111
  and (sel_nor, sel[3], sel[2], nsel1, nsel0);           // 1100

  wire sel_add_sub;
  or (sel_add_sub, sel_add, sel_sub);

  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1) begin : mux_bits
      wire a, b, c, d, e;

      and (a, in0[i], sel_and);        // AND path
      and (b, in1[i], sel_or);         // OR path
      and (c, in2[i], sel_add_sub);    // ADD/SUB path
      and (d, in3[i], sel_slt);        // SLT path
      and (e, in4[i], sel_nor);        // NOR path

      or (out[i], a, b, c, d, e);      // Final OR to select one
    end
  endgenerate

endmodule
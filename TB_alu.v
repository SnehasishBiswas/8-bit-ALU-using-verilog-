`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: College Of Engineering And Management
// Student: Snehasish Biswas 
// Guide: Dr. Hirak Kr Maity
// Create Date: 11.08.2025
// Design Name: Testbench for 8-bit ALU
// Target Device: Xilinx ZYNQ 7000+ Series
//////////////////////////////////////////////////////////////////////////////////
module TB_alu;

    reg [7:0] A, B; 
    reg [3:0] alu_sel;
    wire [7:0] alu_out;
    wire c_out;

    // Instantiate ALU
    alu_8bit uut (
        .A(A),
        .B(B),
        .alu_sel(alu_sel),
        .alu_out(alu_out),
        .c_out(c_out)
    );

    initial begin
        // Apply fixed inputs
        A = 8'd10;  // decimal 10 = 0x0A
        B = 8'd5;   // decimal 5 = 0x05

        // Run through all ALU operations
        $display("Time | alu_sel | Operation | Result | Carry");
        for (alu_sel = 0; alu_sel < 16; alu_sel = alu_sel + 1) begin
            #10;  // wait 10ns for each operation
            $display("%0dns | %b | %s | %d | %b",
                     $time, alu_sel, decode_op(alu_sel), alu_out, c_out);
        end

        #20;
        $finish;
    end

    // Optional helper task to decode alu_sel
    function [128*8:0] decode_op;
        input [3:0] sel;
        begin
            case(sel)
                4'b0000: decode_op = "ADD";
                4'b0001: decode_op = "SUB";
                4'b0010: decode_op = "MUL";
                4'b0011: decode_op = "DIV";
                4'b0100: decode_op = "LSHIFT";
                4'b0101: decode_op = "RSHIFT";
                4'b0110: decode_op = "ROTATE_LEFT";
                4'b0111: decode_op = "ROTATE_RIGHT";
                4'b1000: decode_op = "AND";
                4'b1001: decode_op = "OR";
                4'b1010: decode_op = "XOR";
                4'b1011: decode_op = "NOR";
                4'b1100: decode_op = "NAND";
                4'b1101: decode_op = "XNOR";
                4'b1110: decode_op = "GREATER";
                4'b1111: decode_op = "EQUAL";
                default: decode_op = "UNKNOWN";
            endcase
        end
    endfunction

endmodule

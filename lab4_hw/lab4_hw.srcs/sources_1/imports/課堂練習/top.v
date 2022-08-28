`timescale 1ns / 1ps

module top(
    input clk,rst,
    input [15:0] SW,
    output [6:0] CS,
    output [7:0] AN
    );
    wire rrst;
    reg clk2;
    reg [13:0] num1,num2;
    reg [31:0] cnt;
    reg [31:0]i;
    
    assign rrst = !rst;
    
    always @(posedge clk)
    begin
        if(cnt > 30000000) begin
            cnt <= 32'b0;
            clk2 <= 1'b1;
        end
        else begin
            cnt <= cnt + 1;
            clk2 <= 1'b0;
        end
    end
   
    seg s1(clk,num1,num2,CS,AN);
    CPU cpu(.clk(clk),.rst(rrst),.sw(SW[12:0]));
    
    always @(posedge clk or posedge rrst)
    begin
        if(rrst) begin
                num1 <= 14'b0;
                num2 <= 14'b0;
        end
        else begin
            //num2 <= 12'b000000000010;
            if (cpu.IF.PC[11:2] == 10'd284) begin
                num1 <= cpu.MEM.DM[1][13:0];
                num2 <= cpu.MEM.DM[2][13:0];
            end // Finish when excute the 24-th instruction (End label).
        end
        //num1 <= cpu.ID.IR[25:21];
        //num1 <= cpu.ID.REG[SW[4:0]];
        //num1 <= cnt[11:0];
        //num2 <= cpu.IF.PC[11:2];
        //num1 <= cpu.IF.instruction[cpu.IF.PC[11:2]][31:27];
    end
endmodule

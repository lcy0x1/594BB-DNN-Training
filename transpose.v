module trans(
    input clk,
    input enable,
    input reset,
    input [31:0] x_in,
    input [31:0] y_in,
    input v_in,
    input clear_in,
    input shift,
    output reg [31:0] x_out,
    output reg [31:0] y_out,
    output reg v_out,
    output reg clear_out
);
    reg [31:0] xr;
    always @(posedge clk) begin
        if(reset) begin
            x_out <= 0;
            y_out <= 0;
            v_out <= 0;
            clear_out <= 0;
        end else if(enable) begin
            x_out <= x_in;
            y_out <= shift ? xr : y_in;
            v_out <= v_in;
            xr <= v_in ? x_in : xr;
            clear_out <= clear_in;
        end
    end
endmodule


module t8x8(
    input clk,
    input enable,
    input reset,
    input [31:0] x_in [7:0],
    input [31:0] y_in [7:0],
    input start,
    input [7:0] clear_in,
    input [7:0] shift,
    output [31:0] x_out[7:0],
    output [31:0] y_out [7:0],
    output [7:0] v_out,
    output [7:0] clear_out
);

wire [31:0] x_mid [7:0][7:0];
wire [31:0] y_mid [7:0][7:0];
wire v_mid [7:0][7:0];
wire clear_mid [7:0][7:0];
wire [7:0] v_in;

reg [3:0] v_count = 0;

assign v_in = v_count[0] == 0 ? 8'h11 << v_count[3:1] : 0;

always @(posedge clk) begin
    if(reset)begin
        v_count <= 0;
    end
    else if(enable)begin
        if(start)begin
            v_count <= v_count == 7 ? 0 : v_count + 1;
        end 
        else begin
            v_count <= 0;
        end
    end
end




trans t00(clk, enable, reset, x_in[0], y_mid[0][0], v_in[0], clear_in[0], shift[0], x_mid[0][0], y_out[0], v_mid[0][0], clear_mid[0][0]);
trans t10(clk, enable, reset, x_in[1], y_mid[1][0], v_mid[0][0], clear_in[1], shift[0], x_mid[1][0], y_mid[0][0], v_mid[1][0], clear_mid[1][0]);
trans t20(clk, enable, reset, x_in[2], y_mid[2][0], v_mid[1][0], clear_in[2], shift[0], x_mid[2][0], y_mid[1][0], v_mid[2][0], clear_mid[2][0]);
trans t30(clk, enable, reset, x_in[3], y_mid[3][0], v_mid[2][0], clear_in[3], shift[0], x_mid[3][0], y_mid[2][0], v_mid[3][0], clear_mid[3][0]);
trans t40(clk, enable, reset, x_in[4], y_mid[4][0], v_mid[3][0], clear_in[4], shift[0], x_mid[4][0], y_mid[3][0], v_mid[4][0], clear_mid[4][0]);
trans t50(clk, enable, reset, x_in[5], y_mid[5][0], v_mid[4][0], clear_in[5], shift[0], x_mid[5][0], y_mid[4][0], v_mid[5][0], clear_mid[5][0]);
trans t60(clk, enable, reset, x_in[6], y_mid[6][0], v_mid[5][0], clear_in[6], shift[0], x_mid[6][0], y_mid[5][0], v_mid[6][0], clear_mid[6][0]);
trans t70(clk, enable, reset, x_in[7], y_in[0], v_mid[6][0], clear_in[7], shift[0], x_mid[7][0], y_mid[6][0], v_out[0], clear_mid[7][0]);

trans t01(clk, enable, reset, x_in[0], y_mid[0][1],     v_in[1], clear_mid[0][0], shift[1], x_mid[0][1],    y_out[1], v_mid[0][1], clear_mid[0][1]);
trans t11(clk, enable, reset, x_in[1], y_mid[1][1], v_mid[0][1], clear_mid[1][0], shift[1], x_mid[1][1], y_mid[0][1], v_mid[1][1], clear_mid[1][1]);
trans t21(clk, enable, reset, x_in[2], y_mid[2][1], v_mid[1][1], clear_mid[2][0], shift[1], x_mid[2][1], y_mid[1][1], v_mid[2][1], clear_mid[2][1]);
trans t31(clk, enable, reset, x_in[3], y_mid[3][1], v_mid[2][1], clear_mid[3][0], shift[1], x_mid[3][1], y_mid[2][1], v_mid[3][1], clear_mid[3][1]);
trans t41(clk, enable, reset, x_in[4], y_mid[4][1], v_mid[3][1], clear_mid[4][0], shift[1], x_mid[4][1], y_mid[3][1], v_mid[4][1], clear_mid[4][1]);
trans t51(clk, enable, reset, x_in[5], y_mid[5][1], v_mid[4][1], clear_mid[5][0], shift[1], x_mid[5][1], y_mid[4][1], v_mid[5][1], clear_mid[5][1]);
trans t61(clk, enable, reset, x_in[6], y_mid[6][1], v_mid[5][1], clear_mid[6][0], shift[1], x_mid[6][1], y_mid[5][1], v_mid[6][1], clear_mid[6][1]);
trans t71(clk, enable, reset, x_in[7],     y_in[1], v_mid[6][1], clear_mid[7][0], shift[1], x_mid[7][1], y_mid[6][1],    v_out[1], clear_mid[7][1]);

trans t02(clk, enable, reset, x_in[0], y_mid[0][2],     v_in[2], clear_mid[0][1], shift[2], x_mid[0][2],    y_out[2], v_mid[0][2], clear_mid[0][2]);
trans t12(clk, enable, reset, x_in[1], y_mid[1][2], v_mid[0][2], clear_mid[1][1], shift[2], x_mid[1][2], y_mid[0][2], v_mid[1][2], clear_mid[1][2]);
trans t22(clk, enable, reset, x_in[2], y_mid[2][2], v_mid[1][2], clear_mid[2][1], shift[2], x_mid[2][2], y_mid[1][2], v_mid[2][2], clear_mid[2][2]);
trans t32(clk, enable, reset, x_in[3], y_mid[3][2], v_mid[2][2], clear_mid[3][1], shift[2], x_mid[3][2], y_mid[2][2], v_mid[3][2], clear_mid[3][2]);
trans t42(clk, enable, reset, x_in[4], y_mid[4][2], v_mid[3][2], clear_mid[4][1], shift[2], x_mid[4][2], y_mid[3][2], v_mid[4][2], clear_mid[4][2]);
trans t52(clk, enable, reset, x_in[5], y_mid[5][2], v_mid[4][2], clear_mid[5][1], shift[2], x_mid[5][2], y_mid[4][2], v_mid[5][2], clear_mid[5][2]);
trans t62(clk, enable, reset, x_in[6], y_mid[6][2], v_mid[5][2], clear_mid[6][1], shift[2], x_mid[6][2], y_mid[5][2], v_mid[6][2], clear_mid[6][2]);
trans t72(clk, enable, reset, x_in[7],     y_in[2], v_mid[6][2], clear_mid[7][1], shift[2], x_mid[7][2], y_mid[6][2],    v_out[2], clear_mid[7][2]);

trans t03(clk, enable, reset, x_in[0], y_mid[0][3],     v_in[3], clear_mid[0][2], shift[3], x_mid[0][3],    y_out[3], v_mid[0][3], clear_mid[0][3]);
trans t13(clk, enable, reset, x_in[1], y_mid[1][3], v_mid[0][3], clear_mid[1][2], shift[3], x_mid[1][3], y_mid[0][3], v_mid[1][3], clear_mid[1][3]);
trans t23(clk, enable, reset, x_in[2], y_mid[2][3], v_mid[1][3], clear_mid[2][2], shift[3], x_mid[2][3], y_mid[1][3], v_mid[2][3], clear_mid[2][3]);
trans t33(clk, enable, reset, x_in[3], y_mid[3][3], v_mid[2][3], clear_mid[3][2], shift[3], x_mid[3][3], y_mid[2][3], v_mid[3][3], clear_mid[3][3]);
trans t43(clk, enable, reset, x_in[4], y_mid[4][3], v_mid[3][3], clear_mid[4][2], shift[3], x_mid[4][3], y_mid[3][3], v_mid[4][3], clear_mid[4][3]);
trans t53(clk, enable, reset, x_in[5], y_mid[5][3], v_mid[4][3], clear_mid[5][2], shift[3], x_mid[5][3], y_mid[4][3], v_mid[5][3], clear_mid[5][3]);
trans t63(clk, enable, reset, x_in[6], y_mid[6][3], v_mid[5][3], clear_mid[6][2], shift[3], x_mid[6][3], y_mid[5][3], v_mid[6][3], clear_mid[6][3]);
trans t73(clk, enable, reset, x_in[7],     y_in[3], v_mid[6][3], clear_mid[7][2], shift[3], x_mid[7][3], y_mid[6][3],    v_out[3], clear_mid[7][3]);

trans t04(clk, enable, reset, x_in[0], y_mid[0][4],     v_in[4], clear_mid[0][3], shift[4], x_mid[0][4],    y_out[4], v_mid[0][4], clear_mid[0][4]);
trans t14(clk, enable, reset, x_in[1], y_mid[1][4], v_mid[0][4], clear_mid[1][3], shift[4], x_mid[1][4], y_mid[0][4], v_mid[1][4], clear_mid[1][4]);
trans t24(clk, enable, reset, x_in[2], y_mid[2][4], v_mid[1][4], clear_mid[2][3], shift[4], x_mid[2][4], y_mid[1][4], v_mid[2][4], clear_mid[2][4]);
trans t34(clk, enable, reset, x_in[3], y_mid[3][4], v_mid[2][4], clear_mid[3][3], shift[4], x_mid[3][4], y_mid[2][4], v_mid[3][4], clear_mid[3][4]);
trans t44(clk, enable, reset, x_in[4], y_mid[4][4], v_mid[3][4], clear_mid[4][3], shift[4], x_mid[4][4], y_mid[3][4], v_mid[4][4], clear_mid[4][4]);
trans t54(clk, enable, reset, x_in[5], y_mid[5][4], v_mid[4][4], clear_mid[5][3], shift[4], x_mid[5][4], y_mid[4][4], v_mid[5][4], clear_mid[5][4]);
trans t64(clk, enable, reset, x_in[6], y_mid[6][4], v_mid[5][4], clear_mid[6][3], shift[4], x_mid[6][4], y_mid[5][4], v_mid[6][4], clear_mid[6][4]);
trans t74(clk, enable, reset, x_in[7],     y_in[4], v_mid[6][4], clear_mid[7][3], shift[4], x_mid[7][4], y_mid[6][4],    v_out[4], clear_mid[7][4]);

trans t05(clk, enable, reset, x_in[0], y_mid[0][5],     v_in[5], clear_mid[0][4], shift[5], x_mid[0][5],    y_out[5], v_mid[0][5], clear_mid[0][5]);
trans t15(clk, enable, reset, x_in[1], y_mid[1][5], v_mid[0][5], clear_mid[1][4], shift[5], x_mid[1][5], y_mid[0][5], v_mid[1][5], clear_mid[1][5]);
trans t25(clk, enable, reset, x_in[2], y_mid[2][5], v_mid[1][5], clear_mid[2][4], shift[5], x_mid[2][5], y_mid[1][5], v_mid[2][5], clear_mid[2][5]);
trans t35(clk, enable, reset, x_in[3], y_mid[3][5], v_mid[2][5], clear_mid[3][4], shift[5], x_mid[3][5], y_mid[2][5], v_mid[3][5], clear_mid[3][5]);
trans t45(clk, enable, reset, x_in[4], y_mid[4][5], v_mid[3][5], clear_mid[4][4], shift[5], x_mid[4][5], y_mid[3][5], v_mid[4][5], clear_mid[4][5]);
trans t55(clk, enable, reset, x_in[5], y_mid[5][5], v_mid[4][5], clear_mid[5][4], shift[5], x_mid[5][5], y_mid[4][5], v_mid[5][5], clear_mid[5][5]);
trans t65(clk, enable, reset, x_in[6], y_mid[6][5], v_mid[5][5], clear_mid[6][4], shift[5], x_mid[6][5], y_mid[5][5], v_mid[6][5], clear_mid[6][5]);
trans t75(clk, enable, reset, x_in[7],     y_in[5], v_mid[6][5], clear_mid[7][4], shift[5], x_mid[7][5], y_mid[6][5],    v_out[5], clear_mid[7][5]);

trans t06(clk, enable, reset, x_in[0], y_mid[0][6],     v_in[6], clear_mid[0][5], shift[6], x_mid[0][6],    y_out[6], v_mid[0][6], clear_mid[0][6]);
trans t16(clk, enable, reset, x_in[1], y_mid[1][6], v_mid[0][6], clear_mid[1][5], shift[6], x_mid[1][6], y_mid[0][6], v_mid[1][6], clear_mid[1][6]);
trans t26(clk, enable, reset, x_in[2], y_mid[2][6], v_mid[1][6], clear_mid[2][5], shift[6], x_mid[2][6], y_mid[1][6], v_mid[2][6], clear_mid[2][6]);
trans t36(clk, enable, reset, x_in[3], y_mid[3][6], v_mid[2][6], clear_mid[3][5], shift[6], x_mid[3][6], y_mid[2][6], v_mid[3][6], clear_mid[3][6]);
trans t46(clk, enable, reset, x_in[4], y_mid[4][6], v_mid[3][6], clear_mid[4][5], shift[6], x_mid[4][6], y_mid[3][6], v_mid[4][6], clear_mid[4][6]);
trans t56(clk, enable, reset, x_in[5], y_mid[5][6], v_mid[4][6], clear_mid[5][5], shift[6], x_mid[5][6], y_mid[4][6], v_mid[5][6], clear_mid[5][6]);
trans t66(clk, enable, reset, x_in[6], y_mid[6][6], v_mid[5][6], clear_mid[6][5], shift[6], x_mid[6][6], y_mid[5][6], v_mid[6][6], clear_mid[6][6]);
trans t76(clk, enable, reset, x_in[7],     y_in[6], v_mid[6][6], clear_mid[7][5], shift[6], x_mid[7][6], y_mid[6][6],    v_out[6], clear_mid[7][6]);

trans t07(clk, enable, reset, x_mid[0][6], y_mid[0][7], v_in[7], clear_mid[0][6], shift[7], x_out[0], y_out[7], v_mid[0][7], clear_out[0]);
trans t17(clk, enable, reset, x_mid[1][6], y_mid[1][7], v_mid[0][7], clear_mid[1][6], shift[7], x_out[1], y_mid[0][7], v_mid[1][7], clear_out[1]);
trans t27(clk, enable, reset, x_mid[2][6], y_mid[2][7], v_mid[1][7], clear_mid[2][6], shift[7], x_out[2], y_mid[1][7], v_mid[2][7], clear_out[2]);
trans t37(clk, enable, reset, x_mid[3][6], y_mid[3][7], v_mid[2][7], clear_mid[3][6], shift[7], x_out[3], y_mid[2][7], v_mid[3][7], clear_out[3]);
trans t47(clk, enable, reset, x_mid[4][6], y_mid[4][7], v_mid[3][7], clear_mid[4][6], shift[7], x_out[4], y_mid[3][7], v_mid[4][7], clear_out[4]);
trans t57(clk, enable, reset, x_mid[5][6], y_mid[5][7], v_mid[4][7], clear_mid[5][6], shift[7], x_out[5], y_mid[4][7], v_mid[5][7], clear_out[5]);
trans t67(clk, enable, reset, x_mid[6][6], y_mid[6][7], v_mid[5][7], clear_mid[6][6], shift[7], x_out[6], y_mid[5][7], v_mid[6][7], clear_out[6]);
trans t77(clk, enable, reset, x_mid[7][6], y_in[7], v_mid[6][7], clear_mid[7][6], shift[7], x_out[7], y_mid[6][7], v_out[7], clear_out[7]);



endmodule
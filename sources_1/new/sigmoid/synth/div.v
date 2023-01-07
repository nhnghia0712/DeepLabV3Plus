`timescale 1ns/10ps
module div (
   input  wire        clk      ,
   input  wire        rst_n    ,
   input  wire        ena      ,
   input  wire [31:0] a_in     ,
   input  wire [31:0] b_in     ,
   output reg  [31:0] result   ,
   output reg         overflow ,
   output reg         underflow,
   //output wire        busy,
   output wire        done
);

   wire [23:0] man_a;
   wire [23:0] man_b;
   wire [ 7:0] exp_a;
   wire [ 7:0] exp_b;

   wire [ 8:0] exp_result;
   wire        cmp       ;
   wire [24:0] sub       ;
   reg  [24:0] remain    ;
   reg  [47:0] man_re    ;
   reg  [ 5:0] count     ;
   //wire        busy;
   wire [ 4:0] shift_nor;
   wire [47:0] pre_man  ;
   wire [ 8:0] pre_exp  ;
   wire        round    ;
   wire        sticky   ;
   wire [24:0] man_nor  ;
   wire [23:0] l_man_nor;
   wire [ 8:0] l_exp    ;


   wire [ 5:0] a_tmp       ;
   wire [ 1:0] tmp0        ;
   wire [ 1:0] tmp1        ;
   wire [ 1:0] tmp2        ;
   wire [ 1:0] tmp3        ;
   wire [ 1:0] tmp4        ;
   wire [ 1:0] tmp5        ;
   wire [ 2:0] q_tmp       ;
   reg  [ 1:0] temp_m      ;
   wire [24:0] man_b_tmp   ;
   wire        de_nor_a    ;
   wire        de_nor_b    ;
   wire        pre_exp_zero;
   wire        busy        ;
   //genvar num;
   assign de_nor_a = (a_in[30:23]=='d0) && !(a_in[22:0]=='d0);
   assign de_nor_b = (b_in[30:23]=='d0) && !(b_in[22:0]=='d0);

   assign man_a      = de_nor_a ? {1'b0,a_in[22:0]} : {1'b1,a_in[22:0]};
   assign man_b      = de_nor_b ? {1'b0,b_in[22:0]} : {1'b1,b_in[22:0]};
   assign exp_a      = de_nor_a ? 8'd1 : a_in[30:23];
   assign exp_b      = de_nor_b ? 8'd1 : b_in[30:23];
   assign exp_result = exp_a - exp_b + 'd127;
   assign man_b_tmp  = {1'b0,man_b};
   assign cmp        = remain >= man_b_tmp;
   assign sub        = cmp ? (remain - man_b) << 1'b1 : {remain[23:0],1'b0};
   assign done       = (count == 'd50)&&ena;
   assign busy       = !(count == 'd0)&&ena;
   always@(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         count <= 6'd0;
      end
      else begin
         if (!ena||done) begin
            count <= 6'd0;
         end
         else begin
            count <= count + 1'b1;
         end
      end
   end

   always@(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         man_re <= 48'd0;
         remain <= 25'd0;
      end
      else begin
         if (done) begin
            man_re <= 48'd0;
            remain <= 25'd0;
         end
         else begin
            if (busy) begin
               remain <= (count == 6'd1) ? {1'b0,man_a} : sub;
               man_re <= {man_re[46:0],cmp};
            end
            else begin
               remain <= remain;
               man_re <= man_re;
            end
         end
      end
   end

   lzc4 u_lzc40 (.x_in(man_re[47:44]), .a_out(a_tmp[0]), .q_out(tmp0));
   lzc4 u_lzc41 (.x_in(man_re[43:40]), .a_out(a_tmp[1]), .q_out(tmp1));
   lzc4 u_lzc42 (.x_in(man_re[39:36]), .a_out(a_tmp[2]), .q_out(tmp2));
   lzc4 u_lzc43 (.x_in(man_re[35:32]), .a_out(a_tmp[3]), .q_out(tmp3));
   lzc4 u_lzc44 (.x_in(man_re[31:28]), .a_out(a_tmp[4]), .q_out(tmp4));
   lzc4 u_lzc45 (.x_in(man_re[27:24]), .a_out(a_tmp[5]), .q_out(tmp5));

   assign q_tmp[2] = a_tmp[0]&&a_tmp[1]&&a_tmp[2]&&a_tmp[3];
   assign q_tmp[1] = (a_tmp[0]&&a_tmp[1]&&(!a_tmp[2]))||(a_tmp[0]&&a_tmp[1]&&(!a_tmp[3]));
   assign q_tmp[0] = (a_tmp[0]&&(!a_tmp[1]))||(a_tmp[0]&&a_tmp[2]&&(!a_tmp[3]))||(a_tmp[0]&&a_tmp[2]&&a_tmp[4]);

   always@(*)begin
      case(q_tmp[2:0])
         3'b000 : begin
            temp_m = tmp0;
         end
         3'b001 : begin
            temp_m = tmp1;
         end
         3'b010 : begin
            temp_m = tmp2;
         end
         3'b011 : begin
            temp_m = tmp3;
         end
         3'b100 : begin
            temp_m = tmp4;
         end
         3'b101 : begin
            temp_m = tmp5;
         end
         default : begin
            temp_m = 2'b00;
         end
      endcase
   end

   assign shift_nor    = (a_tmp[5:0]==6'b111111)?5'd0:{q_tmp[2:0],temp_m};
   assign pre_man      = (!(|a_in[30:0])) ? 'd0: man_re << shift_nor;
   assign pre_exp_zero = (a_tmp[5:0]==6'b111111)|| (!(|a_in[30:0]));
   assign pre_exp      = pre_exp_zero ? 9'd0:exp_result-shift_nor;
   assign round        = pre_man[23];
   assign sticky       = |pre_man[22:0];
   assign man_nor      = (round&&sticky)||(round&&pre_man[24])?(pre_man[47:24]+1'b1):{1'b0,pre_man[47:24]};
   assign l_man_nor    = man_nor[24] ? man_nor[24:1]: man_nor[23:0];
   assign l_exp        = man_nor[24]? pre_exp+1'b1: pre_exp;

   always@(*) begin
      if (&exp_b) begin
         if (&exp_a) begin
            result    = {a_in[31]^b_in[31],{31{1'b1}}};
            overflow  = l_man_nor[23]&&1'b0;
            underflow = 1'b0;
         end
         else begin
            result    = {a_in[31]^b_in[31],31'd0};
            overflow  = l_man_nor[23]&&1'b0;
            underflow = 1'b0;
         end
      end
      else begin
         if (b_in[30:0] == 31'd0) begin
            if (a_in[30:0] == 31'd0) begin
               result    = {a_in[31]^b_in[31],{31{1'b1}}};
               overflow  = l_man_nor[23]&&1'b0;
               underflow = 1'b0;
            end
            else begin
               result    = {a_in[31]^b_in[31],8'b11111111,23'd0};
               overflow  = l_man_nor[23]&&1'b0;
               underflow = 1'b0;
            end
         end
         else begin
            result[31]    = a_in[31]^b_in[31];
            result[30:23] = l_exp[7:0];
            result[22:0]  = l_man_nor[22:0];
            overflow      = (exp_a[7] && exp_b[7]) && exp_result[8] ? 1'b1 : 1'b0;
            underflow     = ((!(exp_a[7] && exp_b[7]) && exp_result[8]) || l_exp[8]) ? 1'b1 : 1'b0;
         end
      end
   end
endmodule


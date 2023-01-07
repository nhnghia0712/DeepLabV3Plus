`timescale 1ns/10ps
module mul_pipeline (
   input  wire        clk      ,
   input  wire        rst_n    ,
   input  wire [31:0] a_in     ,
   input  wire [31:0] b_in     ,
   input  wire        ena      ,
   output reg  [31:0] result   ,
   output reg         overflow ,
   output reg         underflow,
   //output wire        busy,
   output wire        done
);

   reg [ 7:0] exp_a_s2;
   reg [ 7:0] exp_b_s2;
   reg [23:0] man_a_s2;
   reg [23:0] man_b_s2;
   reg        s_a_s2  ;
   reg        s_b_s2  ;

   reg        s_a_s3       ;
   reg        s_b_s3       ;
   reg [ 7:0] exp_a_s3     ;
   reg [ 7:0] exp_b_s3     ;
   reg [ 8:0] exp_result_s3;
   reg [22:0] man_a_s3     ;
   reg [22:0] man_b_s3     ;
   reg [47:0] man_re_s3    ;

   reg        s_a_s4       ;
   reg        s_b_s4       ;
   reg [ 7:0] exp_a_s4     ;
   reg [ 7:0] exp_b_s4     ;
   reg [ 8:0] exp_result_s4;
   reg [22:0] man_a_s4     ;
   reg [22:0] man_b_s4     ;
   reg [47:0] man_re_s4    ;
   reg [ 4:0] shift_nor_s4 ;
   //reg          atmp5_s4;

   reg        zero_a_s5   ;
   reg        zero_b_s5   ;
   reg        s_a_s5      ;
   reg        s_b_s5      ;
   reg [ 7:0] exp_a_s5    ;
   reg [ 7:0] exp_b_s5    ;
   reg [23:0] l_man_nor_s5;
   //reg          atmp5_s5;
   reg [8:0] l_exp_s5;

   reg  [ 2:0] count;
   wire [23:0] man_a;
   wire [23:0] man_b;
   wire [ 7:0] exp_a;
   wire [ 7:0] exp_b;

   wire [ 8:0] exp_result;
   wire [47:0] man_re    ;
   wire [ 4:0] shift_nor ;
   wire [47:0] pre_man   ;
   wire [ 8:0] pre_exp   ;
   wire        round     ;
   wire        sticky    ;
   wire [23:0] l_man_nor ;
   wire [ 8:0] l_exp     ;
   wire [24:0] man_nor   ;

   wire [8:0] compare     ;
   wire [5:0] a_tmp       ;
   wire [1:0] tmp0        ;
   wire [1:0] tmp1        ;
   wire [1:0] tmp2        ;
   wire [1:0] tmp3        ;
   wire [1:0] tmp4        ;
   wire [1:0] tmp5        ;
   wire [2:0] q_tmp       ;
   reg  [1:0] temp_m      ;
   wire       de_nor_a    ;
   wire       de_nor_b    ;
   wire       pre_exp_zero;
   wire       zero_a      ;
   wire       zero_b      ;
   //reg         exp_result_8;
   //wire        busy;

   assign done = (count == 'd5)&&ena;
   //assign busy = !(count == 'd0)&&ena;

   always@(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         count <= 'd0;
      end
      else begin
         if (!ena||done) begin
            count <= 'd0;
         end
         else begin
            count <= count + 1'b1;
         end
      end
   end
   ////----STAGE 1----////
   assign de_nor_a = (a_in[30:23]=='d0) && !(a_in[22:0]=='d0);
   assign de_nor_b = (b_in[30:23]=='d0) && !(b_in[22:0]=='d0);

   assign man_a = de_nor_a ? {1'b0,a_in[22:0]} : {1'b1,a_in[22:0]};
   assign man_b = de_nor_b ? {1'b0,b_in[22:0]} : {1'b1,b_in[22:0]};
   assign exp_a = de_nor_a ? 8'd1 : a_in[30:23];
   assign exp_b = de_nor_b ? 8'd1 : b_in[30:23];
   ////----STAGE 2----////
   always@(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         exp_a_s2 <= 'd0;
         exp_b_s2 <= 'd0;
         man_a_s2 <= 'd0;
         man_b_s2 <= 'd0;
         s_a_s2   <= 'd0;
         s_b_s2   <= 'd0;
      end
      else begin
         exp_a_s2 <= exp_a;
         exp_b_s2 <= exp_b;
         man_a_s2 <= man_a;
         man_b_s2 <= man_b;
         s_a_s2   <= a_in[31];
         s_b_s2   <= b_in[31];
      end
   end

   assign exp_result = exp_a_s2 + exp_b_s2 - 'd127;
   assign man_re     = man_a_s2 * man_b_s2;
   ////----STAGE 3----////
   always@(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         exp_a_s3      <= 'd0;
         exp_b_s3      <= 'd0;
         exp_result_s3 <= 'd0;
         man_a_s3      <= 'd0;
         man_b_s3      <= 'd0;
         s_a_s3        <= 'd0;
         s_b_s3        <= 'd0;
         man_re_s3     <= 'd0;
      end
      else begin
         exp_a_s3      <= exp_a_s2;
         exp_b_s3      <= exp_b_s2;
         exp_result_s3 <= exp_result;
         man_a_s3      <= man_a_s2[22:0];
         man_b_s3      <= man_b_s2[22:0];
         s_a_s3        <= s_a_s2;
         s_b_s3        <= s_b_s2;
         man_re_s3     <= man_re;
      end
   end

   lzc4 u_lzc40 (.x_in(man_re_s3[46:43]), .a_out(a_tmp[0]), .q_out(tmp0));
   lzc4 u_lzc41 (.x_in(man_re_s3[42:39]), .a_out(a_tmp[1]), .q_out(tmp1));
   lzc4 u_lzc42 (.x_in(man_re_s3[38:35]), .a_out(a_tmp[2]), .q_out(tmp2));
   lzc4 u_lzc43 (.x_in(man_re_s3[34:31]), .a_out(a_tmp[3]), .q_out(tmp3));
   lzc4 u_lzc44 (.x_in(man_re_s3[30:27]), .a_out(a_tmp[4]), .q_out(tmp4));
   lzc4 u_lzc45 (.x_in(man_re_s3[26:23]), .a_out(a_tmp[5]), .q_out(tmp5));

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

   assign shift_nor = ((a_tmp[5:0] == 6'b111111) && !man_re_s3[47]) ? 5'd0 : {q_tmp[2:0],temp_m};

   ////----STAGE 4----////
   always@(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         exp_a_s4      <= 'd0;
         exp_b_s4      <= 'd0;
         exp_result_s4 <= 'd0;
         man_a_s4      <= 'd0;
         man_b_s4      <= 'd0;
         s_a_s4        <= 'd0;
         s_b_s4        <= 'd0;
         man_re_s4     <= 'd0;
         shift_nor_s4  <= 'd0;
         // atmp5_s4      <= 'd0;
      end
      else begin
         exp_a_s4      <= exp_a_s3;
         exp_b_s4      <= exp_b_s3;
         exp_result_s4 <= exp_result_s3;
         man_a_s4      <= man_a_s3;
         man_b_s4      <= man_b_s3;
         s_a_s4        <= s_a_s3;
         s_b_s4        <= s_b_s3;
         man_re_s4     <= man_re_s3;
         shift_nor_s4  <= shift_nor;
         // atmp5_s4      <= a_tmp[5];
      end
   end

   assign compare = exp_result_s4-shift_nor_s4;
   assign zero_a  = {exp_a_s4,man_a_s4[22:0]}=='d0;
   assign zero_b  = {exp_b_s4,man_b_s4[22:0]}=='d0;
   assign pre_man = compare[8] || zero_a ||zero_b ? 'd0 :
      man_re_s4[47] ? man_re_s4 : {man_re_s4[46:0],1'b0} << shift_nor_s4;
   assign pre_exp_zero = compare[8] || zero_a ||zero_b || (!(|man_re_s4[47:0]));
   assign pre_exp      = pre_exp_zero ? 9'd0:
      man_re_s4[47] ? exp_result_s4+1'b1 : compare;
   assign round     = pre_man[23];
   assign sticky    = |pre_man[22:0];
   assign man_nor   = (round&&sticky)||(round&&pre_man[24])?(pre_man[47:24]+1'b1):{1'b0,pre_man[47:24]};
   assign l_man_nor = man_nor[24] ? man_nor[24:1]: man_nor[23:0];
   assign l_exp     = man_nor[24] ? pre_exp+1'b1: pre_exp;

   ////----STAGE 5----///
   always@(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         exp_a_s5     <= 'd0;
         exp_b_s5     <= 'd0;
         zero_a_s5    <= 'd0;
         zero_b_s5    <= 'd0;
         s_a_s5       <= 'd0;
         s_b_s5       <= 'd0;
         l_man_nor_s5 <= 'd0;
         //exp_result_8 <= 'd0;
         // atmp5_s5     <= 'd0;
         l_exp_s5     <= 'd0;
      end
      else begin
         exp_a_s5     <= exp_a_s4;
         exp_b_s5     <= exp_b_s4;
         zero_a_s5    <= zero_a;
         zero_b_s5    <= zero_b;
         s_a_s5       <= s_a_s4;
         s_b_s5       <= s_b_s4;
         l_man_nor_s5 <= l_man_nor;
         //exp_result_8 <= exp_result_s4[8];
         // atmp5_s5     <= atmp5_s4;
         l_exp_s5     <= l_exp;
      end
   end
   always@(*)begin
      if (exp_b_s5==8'b11111111) begin
         result    = {s_a_s5^s_b_s5,8'b11111111,23'd0};
         overflow  = l_man_nor_s5[23]&&1'b0;
         underflow = 1'b0;
      end
      else begin
         if ((zero_b_s5 && (exp_a_s5==8'b11111111))|| (zero_a_s5 && (exp_b_s5==8'b11111111))) begin
            result    = {s_a_s5^s_b_s5,{31{1'b1}}};
            overflow  = l_exp_s5[8] && 1'b0;
            underflow = 1'b0;
         end
         else begin
            result[31]    = s_a_s5^s_b_s5;
            result[30:23] = l_exp_s5[7:0];
            result[22:0]  = l_man_nor_s5[22:0];
            overflow      = l_exp_s5[8] && (exp_a_s5[7] || exp_b_s5[7]) ? 1'b1:1'b0;
            underflow     = l_exp_s5[8] && (!exp_a_s5[7]) && (!exp_b_s5[7]) ? 1'b1:1'b0;
         end
      end
   end
endmodule

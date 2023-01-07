`timescale 1ns/10ps
module add_sub_pipeline (
   input  wire        clk      ,
   input  wire        rst_n    ,
   input  wire [31:0] a_in     ,
   input  wire [31:0] b_in     ,
   input  wire        sel      ,
   input  wire        ena      ,
   output reg  [31:0] result   ,
   output reg         overflow ,
   output reg         underflow,
   //output wire        busy,
   output wire        done
);

   reg [ 7:0] exp_a_s2   ;
   reg [ 7:0] exp_b_s2   ;
   reg [23:0] man_a_s2   ;
   reg [23:0] man_b_s2   ;
   reg        s_a_s2     ;
   reg        s_b_s2     ;
   reg        de_nor_a_s2;
   reg        de_nor_b_s2;
   reg        a_in31_s2  ;
   reg        zero_a_s2  ;
   reg        zero_b_s2  ;
//   reg          done_s2;
//   reg          busy_s2;

   reg [7:0] exp_a_s3;
   reg [7:0] exp_b_s3;
   //reg [22:0]   man_a_s3;
   //reg [22:0]   man_b_s3;
   reg        s_a_s3       ;
   reg        s_b_s3       ;
   reg [24:0] add_k_s3     ;
   reg [24:0] add_s_s3     ;
   reg        de_nor_a_s3  ;
   reg        de_nor_b_s3  ;
   reg [23:0] rest_s3      ;
   reg [ 7:0] exp_result_s3;
   reg        a_in31_s3    ;
   reg        zero_a_s3    ;
   reg        zero_b_s3    ;
//   reg          done_s3;
//   reg          busy_s3;

   reg [7:0] exp_a_s4;
   reg [7:0] exp_b_s4;
   //reg [22:0]   man_a_s4;
   //reg [22:0]   man_b_s4;
   reg [24:0] sum_ac_s4    ;
   reg        de_nor_a_s4  ;
   reg        de_nor_b_s4  ;
   reg        s_a_s4       ;
   reg        s_b_s4       ;
   reg [23:0] rest_s4      ;
   reg [ 7:0] exp_result_s4;
   reg        s_sum_ac_s4  ;
   reg        a_in31_s4    ;
   reg        zero_a_s4    ;
   reg        zero_b_s4    ;
//   reg          done_s4;
//   reg          busy_s4;

   reg        s_a_s5             ;
   reg        s_b_s5             ;
   reg [ 7:0] exp_a_s5           ;
   reg [ 7:0] exp_b_s5           ;
   reg [23:0] l_man_nor_s5       ;
   reg [ 8:0] l_exp_s5           ;
   reg        man_nor_s5         ;
   reg        plus_2_pos_carry_s5;
   reg        s_sum_ac_s5        ;
   reg        a_in31_s5          ;
//   reg          done_s5;
//   reg          busy_s5;

   wire        zero_a    ;
   wire        zero_b    ;
   wire        s_a       ;
   wire        s_b       ;
   wire [23:0] man_a     ;
   wire [23:0] man_b     ;
   wire [ 7:0] exp_a     ;
   wire [ 7:0] exp_b     ;
   wire [ 7:0] exp_diff  ;
   wire [ 7:0] exp_result;

   wire [47:0] man_shift;
   wire [48:0] man_s    ;
   reg  [24:0] add_s    ;
   wire [24:0] add_k    ;
   wire [24:0] man_k    ;
   wire [24:0] sum      ;
   reg  [24:0] sum_ac   ;
   reg         s_sum_ac ;
   reg  [24:0] rest     ;
   wire [ 4:0] shift_nor;
   wire [48:0] pre_man  ;
   wire [ 8:0] pre_exp  ;
   wire        round    ;
   wire        sticky   ;
   wire [24:0] man_nor  ;
   wire [23:0] l_man_nor;
   wire [ 8:0] l_exp    ;

   reg  [2:0] count                     ;
   wire [5:0] a_tmp                     ;
   wire [1:0] tmp0                      ;
   wire [1:0] tmp1                      ;
   wire [1:0] tmp2                      ;
   wire [1:0] tmp3                      ;
   wire [1:0] tmp4                      ;
   wire [1:0] tmp5                      ;
   wire [2:0] q_tmp                     ;
   reg  [1:0] temp_m                    ;
   wire       de_nor_a                  ;
   wire       de_nor_b                  ;
   wire       plus_2_pos_carry          ;
   wire       no_shift                  ;
   wire       result_de_nor_no_normalize;
   wire       pre_exp_zero              ;
   wire       no_shift_nor              ;
   //wire         busy;

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

   ///-------------STAGE 1---------------///
   assign zero_a = !(|a_in[30:0]);
   assign zero_b = !(|b_in[30:0]);
   assign s_a    = a_in[31] ? !a_in[31]:a_in[31]; //a_in[31]: sign_temp
   assign s_b    = (sel==1'b0)?
      (a_in[31]) ? !b_in[31] : b_in[31] :
      (!a_in[31])? !b_in[31] : b_in[31];

   assign de_nor_a = (a_in[30:23]=='d0) && !(a_in[22:0]=='d0);
   assign de_nor_b = (b_in[30:23]=='d0) && !(b_in[22:0]=='d0);
   assign man_a    = de_nor_a ? {1'b0,a_in[22:0]} : {1'b1,a_in[22:0]};
   assign man_b    = de_nor_b ? {1'b0,b_in[22:0]} : {1'b1,b_in[22:0]};
   assign exp_a    = de_nor_a ? 8'd1 : a_in[30:23];
   assign exp_b    = de_nor_b ? 8'd1 : b_in[30:23];

   //-------------STAGE 2---------------///
   always@(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         exp_a_s2    <= 'd0;
         exp_b_s2    <= 'd0;
         man_a_s2    <= 'd0;
         man_b_s2    <= 'd0;
         s_a_s2      <= 'd0;
         s_b_s2      <= 'd0;
         de_nor_a_s2 <= 'd0;
         de_nor_b_s2 <= 'd0;
         a_in31_s2   <= 'd0;
         zero_a_s2   <= 'd0;
         zero_b_s2   <= 'd0;
//  busy_s2     <= 'd0;
//  done_s2     <= 'd0;
      end
      else begin
         exp_a_s2    <= exp_a;
         exp_b_s2    <= exp_b;
         man_a_s2    <= man_a;
         man_b_s2    <= man_b;
         s_a_s2      <= s_a;
         s_b_s2      <= s_b;
         de_nor_a_s2 <= de_nor_a;
         de_nor_b_s2 <= de_nor_b;
         a_in31_s2   <= a_in[31];
         zero_a_s2   <= zero_a;
         zero_b_s2   <= zero_b;
//  busy_s2     <= 1'b1;
//       done_s2     <= 1'b0;
      end
   end

   assign exp_result = (exp_a_s2 >= exp_b_s2) ? exp_a_s2 : exp_b_s2;

   assign exp_diff  = (exp_a_s2 >= exp_b_s2) ? (exp_a_s2 - exp_b_s2):(exp_b_s2 - exp_a_s2);
   assign man_shift = (exp_a_s2 >= exp_b_s2) ? {man_b_s2,{24{1'b0}}}:{man_a_s2,{24{1'b0}}};// mantissa chosed to shift
   assign man_k     = (exp_a_s2 >= exp_b_s2) ? {s_a_s2,man_a_s2}:{s_b_s2,man_b_s2};//mantissa kept with sign bit
   assign man_s     = (exp_a_s2 >= exp_b_s2) ? {s_b_s2,(man_shift >> exp_diff)}:
      {s_a_s2,(man_shift >> exp_diff)};// mantissa after shifting with sign bit
   assign add_k = (man_k[24]==1) ? {man_k[24], -man_k[23:0]} : man_k; //true mantissa kept with sign bit

   always@(*)begin
      if (exp_diff == 'd0) begin
         add_s = (man_s[48]==1) ? {man_s[48], -man_s[47:24]} : man_s[48:24];
         rest  = 'd0;
      end
      else begin
         if (exp_diff > 'd23) begin
            rest  = (man_s[48]==1) ? -{1'b1,man_shift[47:24]} : {1'b0,man_shift[47:24]};
            add_s = (man_s[48]==1) ? ~{1'b0,man_s[47:24]}+rest[24] : man_s[48:24];
         end
         else begin
            rest  = (man_s[48]==1) ? -{1'b1,man_s[23:0]} : {1'b0,man_s[23:0]};
            add_s = (man_s[48]==1) ? ~{1'b0,man_s[47:24]}+rest[24] : man_s[48:24];
         end
      end
   end
   //-------------STAGE 3---------------///
   always@(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         s_a_s3        <= 'd0;
         s_b_s3        <= 'd0;
         add_k_s3      <= 'd0;
         add_s_s3      <= 'd0;
         de_nor_a_s3   <= 'd0;
         de_nor_b_s3   <= 'd0;
         // man_a_s3      <= 'd0;
         // man_b_s3      <= 'd0;
         exp_a_s3      <= 'd0;
         exp_b_s3      <= 'd0;
         rest_s3       <= 'd0;
         exp_result_s3 <= 'd0;
         a_in31_s3     <= 'd0;
         zero_a_s3     <= 'd0;
         zero_b_s3     <= 'd0;
//  busy_s3       <= 'd0;
//  done_s3       <= 'd0;
      end
      else begin
         s_a_s3        <= s_a_s2;
         s_b_s3        <= s_b_s2;
         add_k_s3      <= add_k;
         add_s_s3      <= add_s;
         de_nor_a_s3   <= de_nor_a_s2;
         de_nor_b_s3   <= de_nor_b_s2;
         //man_a_s3      <= man_a_s2[22:0];
         //man_b_s3      <= man_b_s2[22:0];
         exp_a_s3      <= exp_a_s2;
         exp_b_s3      <= exp_b_s2;
         rest_s3       <= rest[23:0];
         exp_result_s3 <= exp_result;
         a_in31_s3     <= a_in31_s2;
         zero_a_s3     <= zero_a_s2;
         zero_b_s3     <= zero_b_s2;
//  busy_s3       <= 1'b1;
//  done_s3       <= 1'b0;
      end
   end

   assign sum = add_k_s3+add_s_s3;
   always@(*)begin
      if (!(s_a_s3||s_b_s3)) begin
         sum_ac   = sum;
         s_sum_ac = 1'b0;
      end
      else begin
         if (sum[24]) begin
            sum_ac   = {sum[24],-sum[23:0]};
            s_sum_ac = 1'b1;
         end
         else begin
            sum_ac   = sum;
            s_sum_ac = 1'b0;
         end
      end
   end
   //-------------STAGE 4---------------///
   always@(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         sum_ac_s4     <= 'd0;
         s_a_s4        <= 'd0;
         s_b_s4        <= 'd0;
         de_nor_a_s4   <= 'd0;
         de_nor_b_s4   <= 'd0;
         //man_a_s4      <= 'd0;
         //man_b_s4      <= 'd0;
         exp_a_s4      <= 'd0;
         exp_b_s4      <= 'd0;
         rest_s4       <= 'd0;
         s_sum_ac_s4   <= 'd0;
         exp_result_s4 <= 'd0;
         a_in31_s4     <= 'd0;
         zero_a_s4     <= 'd0;
         zero_b_s4     <= 'd0;
//  busy_s4       <= 'd0;
//  done_s4       <= 'd0;
      end
      else begin
         sum_ac_s4     <= sum_ac;
         s_a_s4        <= s_a_s3;
         s_b_s4        <= s_b_s3;
         de_nor_a_s4   <= de_nor_a_s3;
         de_nor_b_s4   <= de_nor_b_s3;
         //man_a_s4      <= man_a_s3;
         //man_b_s4      <= man_b_s3;
         exp_a_s4      <= exp_a_s3;
         exp_b_s4      <= exp_b_s3;
         rest_s4       <= rest_s3;
         s_sum_ac_s4   <= s_sum_ac;
         exp_result_s4 <= exp_result_s3;
         a_in31_s4     <= a_in31_s3;
         zero_a_s4     <= zero_a_s3;
         zero_b_s4     <= zero_b_s3;
//  busy_s4       <= 1'b1;
//  done_s4       <= 1'b0;
      end
   end

   lzc4 u_lzc40 (.x_in(sum_ac_s4[23:20]), .a_out(a_tmp[0]), .q_out(tmp0));
   lzc4 u_lzc41 (.x_in(sum_ac_s4[19:16]), .a_out(a_tmp[1]), .q_out(tmp1));
   lzc4 u_lzc42 (.x_in(sum_ac_s4[15:12]), .a_out(a_tmp[2]), .q_out(tmp2));
   lzc4 u_lzc43 (.x_in(sum_ac_s4[11:8]), .a_out(a_tmp[3]), .q_out(tmp3));
   lzc4 u_lzc44 (.x_in(sum_ac_s4[7:4]), .a_out(a_tmp[4]), .q_out(tmp4));
   lzc4 u_lzc45 (.x_in(sum_ac_s4[3:0]), .a_out(a_tmp[5]), .q_out(tmp5));

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

   assign result_de_nor_no_normalize = (de_nor_a_s4 && de_nor_b_s4);
   assign no_shift                   = (zero_a_s4 && zero_b_s4) || result_de_nor_no_normalize;
   assign no_shift_nor               = no_shift || ((a_tmp[5:0] == 6'b111111) && !sum_ac_s4[24]);

   assign shift_nor = no_shift_nor ? 5'd0 : {q_tmp[2:0],temp_m};

   assign plus_2_pos_carry = !(s_a_s4||s_b_s4) && sum_ac_s4[24];
   assign pre_exp_zero     = (zero_a_s4 && zero_b_s4) || result_de_nor_no_normalize || (!(|sum_ac_s4[24:0]));

   assign pre_man = plus_2_pos_carry ? {sum_ac_s4,rest_s4} : {sum_ac_s4[23:0],rest_s4,1'b0}<<shift_nor;
   assign pre_exp = pre_exp_zero ? 9'd0 :
      plus_2_pos_carry ? exp_result_s4+1'b1: exp_result_s4-shift_nor;
   assign round     = pre_man[24];
   assign sticky    = |pre_man[23:0];
   assign man_nor   = (round&&sticky)||(round&&pre_man[25]) ? (pre_man[48:25]+1'b1) : {1'b0,pre_man[48:25]};
   assign l_man_nor = man_nor[24] ? man_nor[24:1]: man_nor[23:0];
   assign l_exp     = man_nor[24]? pre_exp+1'b1: pre_exp;

   //-------------STAGE 5---------------///
   always@(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         s_a_s5              <= 'd0;
         s_b_s5              <= 'd0;
         exp_a_s5            <= 'd0;
         exp_b_s5            <= 'd0;
         l_man_nor_s5        <= 'd0;
         l_exp_s5            <= 'd0;
         man_nor_s5          <= 'd0;
         plus_2_pos_carry_s5 <= 'd0;
         s_sum_ac_s5         <= 'd0;
         a_in31_s5           <= 'd0;
//  busy_s5             <= 'd0;
//  done_s5             <= 'd0;
      end
      else begin
         s_a_s5              <= s_a_s4;
         s_b_s5              <= s_b_s4;
         exp_a_s5            <= exp_a_s4;
         exp_b_s5            <= exp_b_s4;
         l_man_nor_s5        <= l_man_nor;
         l_exp_s5            <= l_exp;
         man_nor_s5          <= man_nor[24];
         plus_2_pos_carry_s5 <= plus_2_pos_carry;
         s_sum_ac_s5         <= s_sum_ac_s4;
         a_in31_s5           <= a_in31_s4;
//  busy_s5     <= 1'b0;
//  done_s5     <= 1'b1;
      end
   end
   always@(*) begin
      if (!(s_a_s5^s_b_s5) && (exp_a_s5==8'b11111111)&& (exp_b_s5==8'b11111111)) begin
         result    = {a_in31_s5,8'b11111111,23'd0};
         overflow  = l_man_nor_s5[23] &&1'b0;
         underflow = 1'b0;
      end
      else begin
         result[31]    = ((a_in31_s5 ^ s_sum_ac_s5)==1'b1)? 1'b1 : 1'b0;
         result[30:23] = l_exp_s5[7:0];
         result[22:0]  = l_man_nor_s5[22:0];
         overflow      = (plus_2_pos_carry_s5 || man_nor_s5) && l_exp_s5[8] ? 1'b1:1'b0;
         underflow     = !(plus_2_pos_carry_s5 || man_nor_s5) && l_exp_s5[8] ? 1'b1:1'b0;
      end
   end
endmodule

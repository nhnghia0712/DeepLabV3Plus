`timescale 1ns/10ps
`define iteration 30
module cnn_sigmoid_synth (
   input  wire        clk          ,
   input  wire        rst_n        ,
   input  wire        start        ,
   input  wire [31:0] in_fp        ,
   input  wire [31:0] rom_val      ,
   output reg  [ 4:0] addr         ,
   output reg         read_en      ,
   output reg  [31:0] out_fp       ,
   output reg         top_overflow ,
   output reg         top_underflow,
   output reg         done
);

   parameter IDLE = 3'b000;
   parameter S0   = 3'b001;
   parameter S1   = 3'b010;
   parameter S2   = 3'b011;
   parameter S3   = 3'b100;
   parameter S4   = 3'b101;
   parameter S5   = 3'b110;

///----Variable for ALU----///
   wire [31:0] temp_add_sub ;
   wire [31:0] temp_mul     ;
   wire [31:0] temp_div     ;
   wire        rpt1u        ;
   wire        rpt1o        ;
   wire        rpt2u        ;
   wire        rpt2o        ;
   wire        rpt3u        ;
   wire        rpt3o        ;
   wire        done_div     ;
   wire        done_add_sub ;
   wire        done_mul     ;
   wire        ena_div      ;
   wire        ena_add_sub  ;
   wire        ena_mul      ;
   wire        nan_a        ;
   wire        nan_b        ;
   reg         overflow     ;
   reg         underflow    ;
   wire [31:0] old_result   ;
   wire        old_overflow ;
   wire        old_underflow;
   wire        alu_done     ;

///----Variable for sigmoid----///
   reg  [ 2:0] cur_state  ;
   reg  [ 4:0] count      ;
   wire        exp_done   ;
   reg  [31:0] tmp_result ;
   reg         tmp_done   ;
   wire        busy       ;
   reg  [31:0] in_a_reg   ;
   reg  [31:0] in_b_reg   ;
   reg  [ 1:0] sel_reg    ;
   wire [31:0] in_a       ;
   wire [31:0] in_b       ;
   wire [ 1:0] sel        ;
   reg  [31:0] exp_x      ;
   reg  [31:0] prev_result;
   reg  [ 2:0] next_state ;
   reg  [31:0] mul_result ;
   reg  [31:0] old_b      ;
   reg         busy_cal   ;
   reg         start_reg  ;
   reg  [31:0] in_fp_reg  ;
   reg  [31:0] rom_val_reg;
   wire [ 4:0] addr_wr    ;
   wire        read_en_wr ;
   wire [31:0] in_act     ;

   always@(posedge clk or negedge rst_n) begin
      if(!rst_n) begin
         in_fp_reg <= 'd0;
      end
      else begin
         if (busy_cal) begin
            in_fp_reg <= in_fp_reg;
         end
         else begin
            in_fp_reg <= in_fp;
         end
      end
   end

   assign in_act = in_fp_reg[31] ? {1'b0,in_fp_reg[30:0]}:in_fp_reg;

   always@(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         start_reg   <= 'd0;
         rom_val_reg <= 'd0;
      end
      else begin
         start_reg   <= start;
         rom_val_reg <= rom_val;
      end
   end

   always@(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         count <= 'd0;
      end
      else begin
         if (cur_state == IDLE) begin
            count <= 'd0;
         end
         else begin
            if (count == `iteration + 1) begin
               count <= 'd0;
            end
            else begin
               if (busy) begin
                  count <= count;
               end
               else begin
                  count <= count + 1'b1;
               end
            end
         end
      end
   end


   always@(posedge clk or negedge rst_n)begin
      if (!rst_n) begin
         busy_cal <= 'd0;
      end
      else begin
         if (start_reg) begin
            if (!done) begin
               busy_cal <= 'd1;
            end
            else begin
               busy_cal <= 'd0;
            end
         end
         else begin
            if ((cur_state == S5) && tmp_done) begin
               busy_cal <= 'd0;
            end
            else begin
               busy_cal <= busy_cal;
            end
         end
      end
   end

   always@(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         out_fp  <= 'd0;
         done    <= 'd0;
         addr    <= 'd0;
         read_en <= 'd0;
      end
      else begin
         if (cur_state == IDLE) begin
            out_fp  <= out_fp;
            done    <= 'd0;
            addr    <= 'd0;
            read_en <= 'd0;
         end
         else begin
            if (cur_state == S5 && tmp_done) begin
               out_fp  <= tmp_result;
               done    <= tmp_done;
               addr    <= addr_wr;
               read_en <= read_en_wr;
            end
            else begin
               out_fp  <= out_fp;
               done    <= done;
               addr    <= addr_wr;
               read_en <= read_en_wr;
            end
         end
      end
   end

   always@(posedge clk or negedge rst_n)begin
      if (!rst_n) begin
         top_overflow <= 'd0;
      end
      else begin
         if (cur_state == IDLE) begin
            top_overflow <= 'd0;
         end
         else begin
            if (overflow) begin
               top_overflow <= 'd1;
            end
            else begin
               if (!done) begin
                  top_overflow <= top_overflow;
               end
               else begin
                  top_overflow <= 'd0;
               end
            end
         end
      end
   end

   always@(posedge clk or negedge rst_n)begin
      if (!rst_n) begin
         top_underflow <= 'd0;
      end
      else begin
         if (cur_state == IDLE) begin
            top_underflow <= 'd0;
         end
         else begin
            if (underflow) begin
               top_underflow <= 'd1;
            end
            else begin
               if (!done) begin
                  top_underflow <= top_underflow;
               end
               else begin
                  top_underflow <= 'd0;
               end
            end
         end
      end
   end


   always@(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         cur_state <= IDLE;
      end
      else begin
         cur_state <= next_state;
      end
   end

   always@(*) begin
      case (cur_state)
         IDLE : begin
            in_a_reg = 'd0;
            sel_reg  = 'd0;
         end
         S0 : begin
            in_a_reg = in_act;
            sel_reg  = 2'b10;
         end
         S1 : begin
            in_a_reg = rom_val_reg;
            sel_reg  = 2'b10;
         end
         S2 : begin
            if (count == 'd0) begin
               in_a_reg = in_act;
               sel_reg  = 2'b00;
            end
            else begin
               in_a_reg = prev_result;
               sel_reg  = 2'b00;
            end
         end
         S3 : begin
            in_a_reg = 'h3f800000;
            sel_reg  = 2'b00;
         end
         S4 : begin
            in_a_reg = 'h3f800000;
            sel_reg  = 2'b00;
         end
         S5 : begin
            if (in_fp_reg[31]) begin
               in_a_reg = 'h3f800000;
               sel_reg  = 2'b11;
            end
            else begin
               in_a_reg = exp_x;
               sel_reg  = 2'b11;
            end
         end
         default : begin
            in_a_reg = 'd0;
            sel_reg  = 'd0;
         end
      endcase
   end

   always@(*)begin
      if (tmp_done) begin
         in_b_reg = old_b;
      end
      else begin
         if (cur_state == S0) begin
            if (count == 'd0) begin
               in_b_reg = in_act;
            end
            else begin
               in_b_reg = mul_result;
            end
         end
         else begin
            if (cur_state == IDLE) begin
               in_b_reg = 'd0;
            end
            else begin
               in_b_reg = tmp_result;
            end
         end
      end
   end

   always@(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         old_b <= 'd0;
      end
      else begin
         if (cur_state == IDLE) begin
            old_b <= 'd0;
         end
         else begin
            old_b <= in_b;
         end
      end
   end

   always@(posedge clk or negedge rst_n)begin
      if (!rst_n) begin
         mul_result <= 'd0;
      end
      else begin
         if (cur_state == IDLE) begin
            mul_result <= 'd0;
         end
         else begin
            if ((cur_state == S0) && tmp_done) begin
               mul_result <= (&tmp_result[30:23]) ? 'd0 :tmp_result;
            end
            else begin
               mul_result <= mul_result;
            end
         end
      end
   end

   assign addr_wr    = count;
   assign in_a       = in_a_reg;
   assign in_b       = (&tmp_result[30:23]) ? 'd0 : in_b_reg;
   assign sel        = sel_reg;
   assign exp_done   = ((cur_state == S3) && tmp_done) ? 1'b1 : 1'b0;
   assign busy       = (((cur_state == S2) && tmp_done) || (cur_state == IDLE)) ? 1'b0 : 1'b1;
   assign read_en_wr = !exp_done;

   always@(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         exp_x <= 'd0;
      end
      else begin
         if (cur_state == IDLE) begin
            exp_x <= 'd0;
         end
         else begin
            if (exp_done) begin
               exp_x <= tmp_result;
            end
            else begin
               exp_x <= exp_x;
            end
         end
      end
   end

   always@(posedge clk or negedge rst_n)begin
      if (!rst_n) begin
         prev_result <= 'd0;
      end
      else begin
         if (cur_state == IDLE) begin
            prev_result <= 'd0;
         end
         else begin
            if ((cur_state == S2) && tmp_done) begin
               prev_result <= (&tmp_result[30:23]) ? 'd0 : tmp_result;
            end
            else begin
               prev_result <= prev_result;
            end
         end
      end
   end

///------------ALU------------------//

   assign nan_a = (&in_a[30:23]) && (|in_a[22:0]);
   assign nan_b = (&in_b[30:23]) && (|in_b[22:0]);

   assign ena_add_sub = (cur_state == IDLE) ? 1'b0 :
      (!sel[1]) ? 1'b1:1'b0;
   assign ena_div = (cur_state == IDLE) ? 1'b0:
      (sel==2'b11) ? 1'b1:1'b0;
   assign ena_mul = (cur_state == IDLE) ? 1'b0:
      (sel==2'b10) ? 1'b1:1'b0;

   assign old_result    = tmp_result;
   assign old_overflow  = overflow;
   assign old_underflow = underflow;
   assign alu_done      = done_add_sub || done_div || done_mul;

   add_sub_pipeline u_add_sub_pipelibe (
      .clk      (clk         ),
      .rst_n    (rst_n       ),
      .ena      (ena_add_sub ),
      .a_in     (in_a        ),
      .b_in     (in_b        ),
      .sel      (sel[0]      ),
      .result   (temp_add_sub),
      .overflow (rpt1o       ),
      .underflow(rpt1u       ),
      .done     (done_add_sub)
   );

   mul_pipeline u_mul_pipeline (
      .clk      (clk     ),
      .rst_n    (rst_n   ),
      .ena      (ena_mul ),
      .a_in     (in_a    ),
      .b_in     (in_b    ),
      .result   (temp_mul),
      .overflow (rpt2o   ),
      .underflow(rpt2u   ),
      .done     (done_mul)
   );

   div u_div (
      .clk      (clk     ),
      .rst_n    (rst_n   ),
      .ena      (ena_div ),
      .a_in     (in_a    ),
      .b_in     (in_b    ),
      .result   (temp_div),
      .overflow (rpt3o   ),
      .underflow(rpt3u   ),
      .done     (done_div)
   );

   always@(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
         tmp_result <= 32'd0;
         overflow   <= 1'b0;
         underflow  <= 1'b0;
         tmp_done   <= 'd0;
      end
      else begin
         if (nan_a || nan_b) begin
            tmp_result <= {1'b0,{31{1'b1}}};
            overflow   <= 1'b0;
            underflow  <= 1'b0;
            tmp_done   <= alu_done;
         end
         else begin
            if (!alu_done) begin
               tmp_result <= old_result;
               overflow   <= old_overflow;
               underflow  <= old_underflow;
               tmp_done   <= alu_done;
            end
            else begin
               if (!sel[1]) begin
                  tmp_result <= temp_add_sub & {32{!rpt1u}};
                  overflow   <= rpt1o;
                  underflow  <= rpt1u;
                  tmp_done   <= alu_done;
               end
               else begin
                  if (!sel[0]) begin
                     tmp_result <= temp_mul & {32{!rpt2u}};
                     overflow   <= rpt2o;
                     underflow  <= rpt2u;
                     tmp_done   <= alu_done;
                  end
                  else begin
                     tmp_result <= temp_div &  {32{!rpt3u}};
                     overflow   <= rpt3o;
                     underflow  <= rpt3u;
                     tmp_done   <= alu_done;
                  end
               end
            end
         end
      end
   end

///-----------Change state------------//

   always@(*) begin
      case (cur_state)
         IDLE : begin
            if (start_reg) begin
               next_state = S0;
            end
            else begin
               next_state = IDLE;
            end
         end
         S0 : begin
            if (tmp_done) begin
               next_state = S1;
            end
            else begin
               next_state = S0;
            end
         end
         S1 : begin
            if (tmp_done) begin
               next_state = S2;
            end
            else begin
               next_state = S1;
            end
         end
         S2 : begin
            if (tmp_done) begin
               if (count == `iteration) begin
                  next_state = S3;
               end
               else begin
                  next_state = S0;
               end
            end
            else begin
               next_state = S2;
            end
         end
         S3 : begin
            if (tmp_done) begin
               next_state = S4;
            end
            else begin
               next_state = S3;
            end
         end
         S4 : begin
            if (tmp_done) begin
               next_state = S5;
            end
            else begin
               next_state = S4;
            end
         end
         S5 : begin
            if (tmp_done) begin
               next_state = IDLE;
            end
            else begin
               next_state = S5;
            end
         end
         default : begin
            next_state = IDLE;
         end
      endcase
   end
endmodule


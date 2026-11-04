// ============================================================
// Traffic Light - Moore FSM
// Chu trinh: RED -> GREEN -> YELLOW -> RED ...
// Moi trang thai giu trong mot so chu ky clock co dinh.
// ============================================================
`timescale 1ns/1ps

module traffic_light #(
    parameter RED_TIME    = 5,   // so chu ky cua den do
    parameter GREEN_TIME  = 5,   // so chu ky cua den xanh
    parameter YELLOW_TIME = 2    // so chu ky cua den vang
)(
    input  wire clk,
    input  wire rst,             // reset dong bo muc cao -> ve RED
    output reg  red,
    output reg  green,
    output reg  yellow
);

    // ---------- Ma hoa trang thai ----------
    localparam [1:0] S_RED    = 2'd0,
                     S_GREEN  = 2'd1,
                     S_YELLOW = 2'd2;

    reg [1:0] state, next_state;
    reg [3:0] cnt;               // dem so chu ky da o trong trang thai hien tai
    reg [3:0] duration;          // thoi gian cua trang thai hien tai
    wire      done;              // = 1 o chu ky cuoi cung cua trang thai

    always @(*) begin
        case (state)
            S_RED:    duration = RED_TIME;
            S_GREEN:  duration = GREEN_TIME;
            S_YELLOW: duration = YELLOW_TIME;
            default:  duration = RED_TIME;
        endcase
    end

    assign done = (cnt == duration - 1);

    // ========== 1. STATE REGISTER (tuan tu) ==========
    always @(posedge clk) begin
        if (rst) begin
            state <= S_RED;
            cnt   <= 4'd0;
        end else begin
            state <= next_state;
            cnt   <= done ? 4'd0 : cnt + 4'd1;
        end
    end

    // ========== 2. NEXT-STATE LOGIC (to hop) ==========
    always @(*) begin
        next_state = state;      // mac dinh: giu nguyen
        case (state)
            S_RED:    if (done) next_state = S_GREEN;
            S_GREEN:  if (done) next_state = S_YELLOW;
            S_YELLOW: if (done) next_state = S_RED;
            default:            next_state = S_RED;
        endcase
    end

    // ========== 3. OUTPUT LOGIC (Moore: chi phu thuoc state) ==========
    always @(*) begin
        red    = 1'b0;
        green  = 1'b0;
        yellow = 1'b0;
        case (state)
            S_RED:    red    = 1'b1;
            S_GREEN:  green  = 1'b1;
            S_YELLOW: yellow = 1'b1;
            default:  red    = 1'b1;
        endcase
    end

endmodule

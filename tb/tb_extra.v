// ============================================================
// Testbench mo rong cho traffic_light
// Test 1: bam reset khi den dang xanh -> den phai ve do
// Test 2: doi thoi gian RED=3, GREEN=4, YELLOW=1 -> kiem tra so chu ky
// Ket qua mo phong ModelSim: PASS (Test 1 va Test 2 deu dung)
// Tac gia: Nguyen Duy Khoa - SE204859
// ============================================================
`timescale 1ns/1ps

module tb_extra;

    reg clk = 0;
    always #5 clk = ~clk;        // chu ky clock = 10 ns

    integer errors = 0;

    // ---------------- DUT 1: thoi gian mac dinh (5,5,2) ----------------
    reg  rst1 = 1;
    wire red1, green1, yellow1;

    traffic_light #(
        .RED_TIME(5), .GREEN_TIME(5), .YELLOW_TIME(2)
    ) dut1 (
        .clk(clk), .rst(rst1), .red(red1), .green(green1), .yellow(yellow1)
    );

    // ---------------- DUT 2: RED=3, GREEN=4, YELLOW=1 ----------------
    localparam RED2    = 3;
    localparam GREEN2  = 4;
    localparam YELLOW2 = 1;

    reg  rst2 = 1;
    wire red2, green2, yellow2;

    traffic_light #(
        .RED_TIME(RED2), .GREEN_TIME(GREEN2), .YELLOW_TIME(YELLOW2)
    ) dut2 (
        .clk(clk), .rst(rst2), .red(red2), .green(green2), .yellow(yellow2)
    );

    // ============================================================
    // TEST 1: reset khi den dang xanh
    // Y tuong: cho den xanh sang, de xanh them 2 chu ky, roi bam reset
    // va kiem tra den phai ve do (va giu do trong luc con reset)
    // ============================================================
    integer i;
    initial begin
        #12 rst1 = 0;                         // nha reset

        // Doi den xanh sang
        while (green1 !== 1'b1) @(posedge clk);
        // De den xanh sang them 2 chu ky roi moi bam reset
        repeat (2) @(posedge clk);

        $display("[TEST 1] Den dang xanh (G=%b), bam reset", green1);
        rst1 = 1;
        @(posedge clk); #1;

        if (red1 === 1'b1 && green1 === 1'b0 && yellow1 === 1'b0)
            $display("  [OK]  [TEST 1] sau reset den ve DO");
        else begin
            $display("  [LOI] [TEST 1] sau reset R=%b G=%b Y=%b, mong doi R=1 G=0 Y=0",
                     red1, green1, yellow1);
            errors = errors + 1;
        end

        // Giu reset them vai chu ky, den van phai o do
        for (i = 0; i < 3; i = i + 1) begin
            @(posedge clk); #1;
            if (!(red1 === 1'b1 && green1 === 1'b0 && yellow1 === 1'b0)) begin
                $display("  [LOI] [TEST 1] dang giu reset ma den khong do");
                errors = errors + 1;
            end
        end
        rst1 = 0;
    end

    // ============================================================
    // TEST 2: kiem tra so chu ky khi doi thoi gian
    // Y tuong: dem so chu ky lien tiep cua tung den, so voi RED2/GREEN2/YELLOW2
    // ============================================================
    integer cycle2 = 0;
    integer run2   = 0;
    reg [2:0] prev_light2 = 3'b000;
    wire [2:0] light2 = {red2, green2, yellow2};
    reg t2_done = 0;

    task check_run2;
        input [2:0] l;
        input integer n;
        integer expected;
        begin
            case (l)
                3'b100:  expected = RED2;
                3'b010:  expected = GREEN2;
                3'b001:  expected = YELLOW2;
                default: expected = -1;
            endcase
            if (n != expected) begin
                $display("  [LOI] [TEST 2] den %b sang %0d chu ky, mong doi %0d", l, n, expected);
                errors = errors + 1;
            end else
                $display("  [OK]  [TEST 2] den %b sang dung %0d chu ky", l, n);
        end
    endtask

    always @(posedge clk) begin
        if (!rst2) begin
            cycle2 = cycle2 + 1;
            $display("[TEST 2] cycle %2d | R=%b G=%b Y=%b", cycle2, red2, green2, yellow2);

            if ((red2 + green2 + yellow2) != 1) begin
                $display("  [LOI] [TEST 2] khong dung 1 den sang!");
                errors = errors + 1;
            end

            if (light2 != prev_light2 && prev_light2 != 3'b000) begin
                check_run2(prev_light2, run2);
                run2 = 1;
            end else
                run2 = run2 + 1;
            prev_light2 = light2;
        end
    end

    initial begin
        #12 rst2 = 0;
        // Chay 2 vong day du + 1 chu ky de kiem tra tung den sang dung so chu ky
        #((2 * (RED2 + GREEN2 + YELLOW2) + 1) * 10);
        t2_done = 1;
    end

    // ============================================================
    // Ket luan
    // ============================================================
    initial begin
        $dumpfile("tb_extra.vcd");
        $dumpvars(0, tb_extra);

        wait (t2_done);
        #20;
        if (errors == 0) $display("==== PASS: khong co loi ====");
        else             $display("==== FAIL: %0d loi ====", errors);
        $finish;
    end

endmodule
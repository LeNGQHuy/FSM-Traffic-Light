// ============================================================
// Testbench cho traffic_light
// - In trang thai den moi chu ky
// - Tu kiem tra: moi luc chi 1 den sang, va moi den sang dung so chu ky
// ============================================================
`timescale 1ns/1ps

module tb_traffic_light;

    localparam RED_TIME    = 5;
    localparam GREEN_TIME  = 5;
    localparam YELLOW_TIME = 2;

    reg  clk = 0;
    reg  rst = 1;
    wire red, green, yellow;

    traffic_light #(
        .RED_TIME(RED_TIME), .GREEN_TIME(GREEN_TIME), .YELLOW_TIME(YELLOW_TIME)
    ) dut (
        .clk(clk), .rst(rst), .red(red), .green(green), .yellow(yellow)
    );

    always #5 clk = ~clk;        // chu ky clock = 10 ns

    integer cycle  = 0;
    integer run    = 0;          // so chu ky lien tiep cua den hien tai
    integer errors = 0;
    reg [2:0] prev_light = 3'b000;
    wire [2:0] light = {red, green, yellow};

    // Kiem tra so chu ky khi den doi mau
    task check_run;
        input [2:0] l;
        input integer n;
        integer expected;
        begin
            case (l)
                3'b100:  expected = RED_TIME;
                3'b010:  expected = GREEN_TIME;
                3'b001:  expected = YELLOW_TIME;
                default: expected = -1;
            endcase
            if (n != expected) begin
                $display("  [LOI] den %b sang %0d chu ky, mong doi %0d", l, n, expected);
                errors = errors + 1;
            end else
                $display("  [OK]  den %b sang dung %0d chu ky", l, n);
        end
    endtask

    // Lay mau ngay tai canh len: doc gia tri cua chu ky vua ket thuc
    always @(posedge clk) begin
        if (!rst) begin
            cycle = cycle + 1;
            $display("cycle %2d | R=%b G=%b Y=%b", cycle, red, green, yellow);

            if ((red + green + yellow) != 1) begin
                $display("  [LOI] khong dung 1 den sang!");
                errors = errors + 1;
            end

            if (light != prev_light && prev_light != 3'b000) begin
                check_run(prev_light, run);
                run = 1;
            end else
                run = run + 1;
            prev_light = light;
        end
    end

    initial begin
        $dumpfile("tb_traffic_light.vcd");   // de xem song bang GTKWave neu can
        $dumpvars(0, tb_traffic_light);

        #12 rst = 0;                          // nha reset sau ~1 chu ky
        #((2 * (RED_TIME + GREEN_TIME + YELLOW_TIME) + 1) * 10);  // chay 2 vong + 1

        if (errors == 0) $display("==== PASS: khong co loi ====");
        else             $display("==== FAIL: %0d loi ====", errors);
        $finish;
    end

endmodule

# Bảng trạng thái – Traffic Light Moore FSM

Nguồn: `rtl/traffic_light.v`. Chu trình: RED → GREEN → YELLOW → RED.

## 1. Bảng mã hóa trạng thái

| Trạng thái | Mã (state[1:0]) | Thời gian giữ (chu kỳ clock) |
|------------|-----------------|------------------------------|
| S_RED      | 2'b00           | RED_TIME = 5                 |
| S_GREEN    | 2'b01           | GREEN_TIME = 5               |
| S_YELLOW   | 2'b10           | YELLOW_TIME = 2              |
| (không dùng) | 2'b11         | Quay về RED (nhánh default)  |

## 2. Bảng chuyển trạng thái

`done = 1` khi bộ đếm `cnt == duration - 1` (chu kỳ cuối của trạng thái).

| Trạng thái hiện tại | rst | done | Trạng thái kế tiếp |
|---------------------|-----|------|--------------------|
| bất kỳ              | 1   | x    | S_RED (cnt = 0)    |
| S_RED               | 0   | 0    | S_RED              |
| S_RED               | 0   | 1    | S_GREEN            |
| S_GREEN             | 0   | 0    | S_GREEN            |
| S_GREEN             | 0   | 1    | S_YELLOW           |
| S_YELLOW            | 0   | 0    | S_YELLOW           |
| S_YELLOW            | 0   | 1    | S_RED              |

Reset đồng bộ, mức cao (`rst`), đưa FSM về S_RED.

## 3. Bảng đầu ra (Moore: chỉ phụ thuộc trạng thái)

| Trạng thái | red | green | yellow |
|------------|-----|-------|--------|
| S_RED      | 1   | 0     | 0      |
| S_GREEN    | 0   | 1     | 0      |
| S_YELLOW   | 0   | 0     | 1      |

## 4. Sơ đồ trạng thái

Xem `docs/state_diagram.png`.
 Nhận xét dạng sóng

- Kết quả mô phỏng: PASS (không có lỗi trong Transcript của ModelSim).
- Ảnh 1 (waveform_full.png): đèn chạy đúng thứ tự RED -> GREEN -> YELLOW
  rồi lặp lại. Trạng thái FSM đi 0 -> 1 -> 2 -> 0. Bộ đếm đếm từ 0 lên
  4 ở trạng thái RED và GREEN (5 chu kỳ clock mỗi trạng thái), còn
  trạng thái YELLOW đếm 0 -> 1 (2 chu kỳ clock). Khi chuyển trạng thái,
  bộ đếm về 0.
- Ảnh 2 (waveform_transition.png): chu kỳ clock là 10 ns. Tại cạnh lên
  của clock (khoảng 55000 ps), khi bộ đếm đếm hết 4 của trạng thái RED
  thì red tắt, green sáng, FSM đổi từ 0 sang 1 và bộ đếm về 0. Các tín
  hiệu đổi cùng một thời điểm, đồng bộ với cạnh lên của clock.
- Reset: ở đầu mô phỏng rst bằng 1 rồi xuống 0; sau đó mạch bắt đầu ở
  trạng thái RED (state = 0, red = 1).
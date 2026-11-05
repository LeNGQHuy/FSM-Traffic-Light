# 🚦 Traffic Light Controller – Moore FSM

> Dự án môn Thiết kế số – **Nhóm MCE7**

---

## 📖 Giới thiệu

Dự án thiết kế **bộ điều khiển đèn giao thông** bằng **máy trạng thái hữu hạn (FSM) kiểu Moore**, viết bằng **Verilog HDL** và mô phỏng trên **ModelSim**.

Đèn hoạt động theo chu trình **🔴 RED → 🟢 GREEN → 🟡 YELLOW → 🔴 RED**, mỗi trạng thái được giữ trong một số chu kỳ clock cố định:

| Trạng thái | Thời gian  |
|:----------:|:----------:|
| 🔴 RED     | 5 chu kỳ   |
| 🟢 GREEN   | 5 chu kỳ   |
| 🟡 YELLOW  | 2 chu kỳ   |

---

## 🎯 Mục đích

- Làm quen với cách mô hình hóa hệ thống tuần tự bằng **FSM**
- Nắm cấu trúc chuẩn của FSM gồm 3 khối: **state register – next-state logic – output logic**
- Hiểu đặc điểm của **Moore FSM**: output chỉ phụ thuộc vào trạng thái hiện tại
- Rèn kỹ năng viết **testbench** và kiểm chứng thiết kế bằng mô phỏng
- Làm việc nhóm với **Git/GitHub**

---

## 📦 Dự án gồm những gì

| Thành phần | Mô tả |
|------------|-------|
| `rtl/traffic_light.v` | Thiết kế FSM đèn giao thông |
| `tb/tb_traffic_light.v` | Testbench tự kiểm tra, in kết quả PASS/FAIL |
| `tb/tb_extra.v` | Testbench mở rộng: reset giữa chừng, đổi tham số thời gian |
| `sim/run.do` | Script chạy mô phỏng trên ModelSim |
| `docs/waveform/` | Ảnh dạng sóng và nhận xét kết quả mô phỏng |
| `docs/state_diagram.png` | Sơ đồ trạng thái |
| `docs/state_table.md` | Bảng mã hóa và bảng chuyển trạng thái |
| `docs/report.md` | Báo cáo tổng hợp |

---

## 👥 Thành viên nhóm MCE7

| STT | Họ và tên | MSSV | GitHub | Vai trò |
|:---:|-----------|:----:|--------|---------|
| 1 | Lê Nguyễn Quang Huy | SE201771 | [LeNGQHuy](https://github.com/LeNGQHuy) | Nhóm trưởng – Thiết kế FSM, testbench, quản lý repo |
| 2 | Mai Anh Khoa | SE204346 | [truongdaihocfpt500-cell](https://github.com/truongdaihocfpt500-cell) | Mô phỏng ModelSim, phân tích dạng sóng |
| 3 | Nguyễn Duy Khoa | SE204859 | [khoalololol67](https://github.com/khoalololol67) | Testbench mở rộng |
| 4 | Lê Quốc Anh | SE203918 | [anhlq197](https://github.com/anhlq197) | Sơ đồ trạng thái, bảng trạng thái |
| 5 | Quách Đăng Khoa | SE204866 | [biquach1011-netizen](https://github.com/biquach1011-netizen) | Viết báo cáo |

---

<p align="center"><b>Nhóm MCE7</b> · 2026</p>

# 🚦 Traffic Light FSM (Moore)

Den giao thong 3 trang thai, chu trinh **RED → GREEN → YELLOW → RED**.

| Trang thai | So chu ky | Output          |
|------------|-----------|-----------------|
| RED        | 5         | red = 1         |
| GREEN      | 5         | green = 1       |
| YELLOW     | 2         | yellow = 1      |

Thiet ke gom 3 khoi: **state register** + **next-state logic** + **output logic**.
Day la Moore FSM vi output chi phu thuoc vao trang thai hien tai.

## Cau truc thu muc

```
rtl/traffic_light.v      # thiet ke FSM
tb/tb_traffic_light.v    # testbench (tu kiem tra PASS/FAIL)
sim/run.do               # script chay ModelSim
```

## Chay mo phong (ModelSim)

1. Mo ModelSim → `File > Change Directory...` → chon thu muc `sim/`
2. Go trong cua so Transcript: `do run.do`
3. Xem song o cua so Wave, xem ket qua PASS/FAIL o Transcript

## Phan cong

| Thanh vien | Viec                                               | File / thu muc                    |
|------------|----------------------------------------------------|-----------------------------------|
| TV1 (truong nhom) | Tao repo, review & merge PR; state register + next-state logic | `rtl/traffic_light.v` |
| TV2        | Output logic + tham so thoi gian (RED/GREEN/YELLOW) | `rtl/traffic_light.v`             |
| TV3        | Testbench tu kiem tra PASS/FAIL                    | `tb/tb_traffic_light.v`           |
| TV4        | Script ModelSim, chay mo phong, chup anh song      | `sim/run.do`, `docs/waveform/`    |
| TV5        | So do trang thai, bang chuyen trang thai, bao cao  | `docs/state_diagram.png`, `docs/report.md` |

Quy tac: moi nguoi lam tren **nhanh rieng** (vd `tv3-testbench`), push bang **tai khoan cua minh**, roi tao Pull Request de truong nhom merge.

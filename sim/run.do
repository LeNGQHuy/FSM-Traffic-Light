# Chay trong ModelSim: File > Change Directory... chon thu muc sim/
# roi go lenh:  do run.do

vlib work
vlog ../rtl/traffic_light.v ../tb/tb_traffic_light.v
vsim -voptargs=+acc work.tb_traffic_light

add wave -divider "Inputs"
add wave /tb_traffic_light/clk
add wave /tb_traffic_light/rst
add wave -divider "Outputs"
add wave /tb_traffic_light/red
add wave /tb_traffic_light/green
add wave /tb_traffic_light/yellow
add wave -divider "Ben trong FSM"
add wave -radix unsigned /tb_traffic_light/dut/state
add wave -radix unsigned /tb_traffic_light/dut/cnt

run -all
wave zoom full

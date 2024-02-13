onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLK /valid_code_check_tb/clk
add wave -noupdate -label ENABLE /valid_code_check_tb/enable
add wave -noupdate -label COUNTER /valid_code_check_tb/counter
add wave -noupdate -label DIN /valid_code_check_tb/din
add wave -noupdate -divider Output
add wave -noupdate -label ERROR /valid_code_check_tb/err
add wave -noupdate -label NOT_ERR /valid_code_check_tb/nerr
add wave -noupdate -label ENA /valid_code_check_tb/ena
add wave -noupdate -label RST /valid_code_check_tb/rst
add wave -noupdate -divider Internal Signals
add wave -noupdate -label STATE /valid_code_check_tb/t1/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 73
configure wave -valuecolwidth 64
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {420 ns}

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLOCK /Counter_tb/clk
add wave -noupdate -label RESET /Counter_tb/rst
add wave -noupdate -label ENABLE /Counter_tb/ena
add wave -noupdate -label UP_DOWN /Counter_tb/u_d
add wave -noupdate -divider Output
add wave -noupdate -label COUNT /Counter_tb/count
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
WaveRestoreZoom {0 ps} {500 ns}


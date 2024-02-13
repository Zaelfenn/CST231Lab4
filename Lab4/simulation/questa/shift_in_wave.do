onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLK /shift_in_tb/clk
add wave -noupdate -label DIN /shift_in_tb/din
add wave -noupdate -label ENABLE /shift_in_tb/enable
add wave -noupdate -divider Output
add wave -noupdate -label DOUT /shift_in_tb/dout
add wave -noupdate -label ENA /shift_in_tb/ena
add wave -noupdate -divider Internal Signals
add wave -noupdate -label STATE /shift_in_tb/t1/state
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
WaveRestoreZoom {0 ps} {180 ns}

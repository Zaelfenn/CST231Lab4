# stop any simulation that is currently running
quit -sim

# create the default "work" library
vlib work;

# compile the Verilog source code in the parent folder
vlog ../../*.v

# compile the Verilog code of the testbench
vlog *.v

# start the Simulator, including some libraries
vsim work.valid_code_check_tb -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"

# show waveforms specified in wave.do
do valid_code_wave.do

# advance the simulation the desired amount of time
run 400 ns

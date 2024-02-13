toplevel .readout
button .readout.a -text {Shift-in SM TestBench} -command {
    do ShiftInTB.tcl
}

button .readout.b -text {Counter TestBench} -command {
    do CounterTB.tcl
}

button .readout.c -text {SevenSegDecoder TestBench} -command {
    do SevenSegTB.tcl
}

button .readout.d -text {Valid Code Check TestBench} -command {
    do ValidCodeCheckTB.tcl
}

pack .readout.a .readout.b .readout.c .readout.d 

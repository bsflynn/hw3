#!/bin/bash
	echo "" > results/block_design_timing_100.txt
	3dDeconvolve -nodata 300 1 -polort 1 \
	-num_stimts 3 \
	-stim_times 1 block_times/blockt.100.A.txt 'BLOCK(100)' -stim_label 1 'A' \
	-stim_times 2 block_times/blockt.100.B.txt 'BLOCK(100)' -stim_label 2 'B' \
	-stim_times 3 block_times/blockt.100.C.txt 'BLOCK(100)' -stim_label 3 'C' \
	-gltsym "SYM: A -B" -gltsym "SYM: A -C" \
	> results/block_design_timing_100.txt
	echo "" >> results/block_design_timing_100.txt
	scripts/efficiency_parser.py results/block_design_timing_100.txt >> results/block_design_timing_100.txt
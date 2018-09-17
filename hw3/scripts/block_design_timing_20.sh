#!/bin/bash
	echo "" > results/block_design_timing_20.txt
	3dDeconvolve -nodata 300 1 -polort 1 \
	-num_stimts 3 \
	-stim_times 1 block_times/blockt.20.A.txt 'BLOCK(20)' -stim_label 1 'A' \
	-stim_times 2 block_times/blockt.20.B.txt 'BLOCK(20)' -stim_label 2 'B' \
	-stim_times 3 block_times/blockt.20.C.txt 'BLOCK(20)' -stim_label 3 'C' \
	-gltsym "SYM: A -B" -gltsym "SYM: A -C" \
	> results/block_design_timing_20.txt
	echo "" >> results/block_design_timing_20.txt
	scripts/efficiency_parser.py results/block_design_timing_20.txt >> results/block_design_timing_20.txt
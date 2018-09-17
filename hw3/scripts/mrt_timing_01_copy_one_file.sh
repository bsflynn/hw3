#!/bin/bash
	3dDeconvolve -nodata 300 1 -polort 1 \
	-num_stimts 3 \
	-stim_times 1 times/stimt_730_01_A.1D 'GAM' -stim_label 1 'A' \
	-stim_times 2 times/stimt_730_02_B.1D 'GAM' -stim_label 2 'B' \
	-stim_times 3 times/stimt_730_03_C.1D 'GAM' -stim_label 3 'C' \
	-gltsym "SYM: A -B" -gltsym "SYM: A -C" \
	-xjpeg results/mrtdesign730_max_consec.png
	#one file attempt

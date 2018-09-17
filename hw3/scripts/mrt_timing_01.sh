#!/bin/bash
echo "" > results/efficiency_mrt.txt
for i in `seq $1`; do
	#Generates a random stimulus order - Reproduce RSFgen?
	make_random_timing.py \
	-num_stim 3 -num_runs 1 \
	-run_time 300 \
	-stim_labels A B C \
	-num_reps 20 \
	-prefix times/stimt_${i} \
	-stim_dur 0 \
	-seed ${i}
	#3dDeconvolve step
	3dDeconvolve -nodata 300 1 -polort 1 \
	-num_stimts 3 \
	-stim_times 1 times/stimt_${i}_01_A.1D 'GAM' -stim_label 1 'A' \
	-stim_times 2 times/stimt_${i}_02_B.1D 'GAM' -stim_label 2 'B' \
	-stim_times 3 times/stimt_${i}_03_C.1D 'GAM' -stim_label 3 'C' \
	-gltsym "SYM: A -B" -gltsym "SYM: A -C" \
	>times/RSFgen_output_${i}_mrt.txt
	efficiency=`scripts/efficiency_parser.py times/RSFgen_output_${i}_mrt.txt`
	echo "$efficiency $i" >> results/efficiency_mrt.txt
done
sort -n -k 1 results/efficiency_mrt.txt> results/efficiency_mrt_sort.txt
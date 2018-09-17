#!/bin/bash
echo "" > results/efficiency.txt
for i in `seq $1`; do
	#Generates a random stimulus order
	RSFgen \
	-nt 300 \
	-num_stimts 3 \
	-nreps 1 20 \
	-nreps 2 20 \
	-nreps 3 20 \
	-seed $i \
	-prefix times/stim_${i}_
	#Converts the RSFgen output to times
	make_stim_times.py \
	-files times/stim_${i}_*.1D \
	-prefix stimt_${i} \
	-nt 300 \
	-tr 1 \
	-nruns 1
	#Evaluates the design using 3dDeconvolve (redirecting the output to a file)
	3dDeconvolve -nodata 300 1 -polort 1 \
	-num_stimts 3 \
	-stim_times 1 times/stimt_${i}.01.1D 'GAM' -stim_label 1 'A' \
	-stim_times 2 times/stimt_${i}.02.1D 'GAM' -stim_label 2 'B' \
	-stim_times 3 times/stimt_${i}.03.1D 'GAM' -stim_label 3 'C' \
	-gltsym "SYM: A -B" -gltsym "SYM: A -C" \
	> times/RSFgen_output_${i}.txt
	#-xjpeg times/design_${i}.png \
	
	#Runs the provided efficiency_parser.py script on the 3dDeconvolve output file. 
		#This script will parse the 3dDeconvolve ouptut and print out the average efficiency of any 
		#contrasts you have specified.
	efficiency=`scripts/efficiency_parser.py times/RSFgen_output_${i}.txt`
	#Prints out two columns for each design, the first containing the efficiency and the second containing the seed
		#Hint: Use `` to store the output efficiency_parser.py in a variable
		#You can print the required values with something like echo "$efficiency $i"
	echo "$efficiency $i" >> results/efficiency.txt

done

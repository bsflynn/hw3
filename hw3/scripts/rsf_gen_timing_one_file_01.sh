#!/bin/bash
	RSFgen \
	-nt 300 \
	-num_stimts 3 \
	-one_file \
	-nreps 1 20 \
	-nreps 2 20 \
	-nreps 3 20 \
	-seed 383 \
	-prefix times/stim_383
	1dplot -one -png results/design.png times/stim_383.1D
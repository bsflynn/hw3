#Q1
--
##What do you observe about the timing structure of the best design? Why is this? It may be helpful to plot some of the less efficient designs for comparison.

I plotted seed 213 (the worst efficiency seed) as `test2design.png`, seed 212 as `testdesign.png`, and the most efficient seed (383) as `design.png`. The two test designs have more overlaps in different stimuli (or colors) on the graph. There are also larger gaps of no stimulus than on the most efficent design. 

This is because we want less colinearity for A-B and A-C, so, as we eyeballed in class, we would like the different stimuli to occur with more time in between to allow the BOLD response to return to baseline. 


#Q2
--
##What do you observe about the timing structure of the best design compared to the best `RSFgen` design? Why is this? 

I only ran the `mrt_timing_01.sh` for 1000 cases, however I got the same random seed as the best design (N=383). I saved the `3dDeconvolve` using the `-xjpeg` option for both the `RSFgen` 383 seed (saved as `design383.png`) and the MRT 383 seed (saved as `mrtdesign383.png`). 

#####Differences: 
The best MRT design has darker lines, so a higher amplitude than the best `RSFgen` design. There also appears to be less time gaps in which there is no stimulus. Finally, there appears to be less overlap in bars for each stimulus. 

#####Possible Reasons:
The darker lines (or higher amplitudes) could be due to the spacing between stimuli caused by constraints on ITI. Thus, the BOLD response has more time to return to baseline, so when convolved with the stimulus timing, the data has greater amplitude (like in slide 41 of `03a-fmri_experimental_design.pdf` from class). Similarly, forcing a constraint on ITI would force the stimuli we test (A, B, C) have a certain time gap, which could explain the lack of overlap for consecutive stimuli in the MRT design compared to the `RSFgen` design. The maximum constraint on ITI could explain the lack of "empty space" in the design. Trials need to begin at least 5 seconds since the previous trial ended, so there is not an empty gap of no stimuli as in the `RSFgen` design. 

#Q3
--
##What do you observe about the timing structure of the best design compared to the best `RSFgen` design? Why is this?

I ran the program limiting the number of constraints for only 1000 cases. By rerunning the script with `-max_consec 1`, the best seed is now 730. I saved the `3dDeconvolve` `-xjpeg` as `mrtdesign730_max_consec.png` in the results folder. 

#####Comparison
Comparing the best `RSFgen` design from Q1 to the best MRT design with `-max_consec` constraints, the lines are darker (amplitude is higher) and there are no times in which the consecutive stimuli are the same. Also, similarly to before without the `-max_consec` constraint, there are more gaps between stimuli and no large gaps of no stimulus. 

#####Possible Reasons:
The possible reasons for differences that were similar without the `-max_consec` constraint are probably the same as in Q3. The main difference between comparing the Q1 and Q2 design vs. comparing the Q1 and Q3 design is the ordering of stimuli. It is likely that the ordering of stimuli (no consecutive stimuli are the same) is due to the `-max_consec` constraint option. Since this limits the number of consecutive presentations to 1, no two consecutive stimuli can be the same condition. In the `RSFgen` design, we did not have a constraint on this, so ordering of stimuli were completely random. 

#Q4
--
##What generalizations can you make about optimal designs from your observations in Q1-3?

From Q1-3, it appears that the best designs may constrain the ITI to have a minimum and maximum, this way the BOLD response can have a large amplitude and enough time to return to baseline (minimum constraint) but there are no long periods of no stimuli (maximum constraint). It also appears that, to test in a subtraction model, having purely random stimuli have consecutive stimuli of the same type, whereas ideally, we want to contrast two different types of stimuli so the constraint on the maximum number repetitions may be a better the design. However, we can see the efficiency values (from the `efficiency_parser.py` program) are higher for the design with constraints on ITI and `-max_consec` than the random `RSFgen` design, so it looks like the most efficient models would be the purely random ones (most efficient `RSFgen` model had efficiency of 0.15455, but the most efficient MRT model with all the constraints was 0.20075). Below are the results of `3dDeconvolve` for the most efficient designs of each type:

`RSFgen` seed 383:
>General Linear Test: GLT#1  
>  LC[0] norm. std. dev. =   0.1501 
>
>General Linear Test: GLT#2  
>  LC[0] norm. std. dev. =   0.1590 

MRT constraints seed 730:
>General Linear Test: GLT#1  
>  LC[0] norm. std. dev. =   0.1994 
>
>General Linear Test: GLT#2  
>  LC[0] norm. std. dev. =   0.2021 

However, these numbers should be relative, so something in the MRT program vs. the `RSFgen` program may make these results not comparable. In that case, it would seem that the MRT program with many constraints may be more optimal than the `RSFgen` design as stated previously. 

#Q5
--
##How does design efficiency for each of the contrasts change using different block durations? Is there an efficiency difference for A-B vs A-C? Why?

The results of the block design efficiency (from `3dDeconvolve` with last line from `efficiency_parser.py`) for t=20 was:

>General Linear Test: GLT#1  
>  LC[0] norm. std. dev. =   0.0308 
>
>General Linear Test: GLT#2  
>  LC[0] norm. std. dev. =   0.0312 

>0.031

The results of the block design efficiency (from `3dDeconvolve` with last line from `efficiency_parser.py`) for t=50 was:

>General Linear Test: GLT#1  
>  LC[0] norm. std. dev. =   0.0298 
>
>General Linear Test: GLT#2  
>  LC[0] norm. std. dev. =   0.0325 
>
>0.03115

The results of the block design efficiency (from `3dDeconvolve` with last line from `efficiency_parser.py`) for t=100 was:

>General Linear Test: GLT#1  
>  LC[0] norm. std. dev. =   0.0513 
>
>General Linear Test: GLT#2  
>  LC[0] norm. std. dev. =   0.0894 
>
>0.07035

So, the most efficient design to test A-B was t=50, the second most efficient design was t=20, and the least efficient design was t=100. The most efficent design to test A-C was t=20, the second most efficient design was t=50, and the least efficient design was t=100. 

However, using the `efficiency_parser.py` program, the most efficient design overall was t=20 followed by t=50 then t=100. This makes sense since there are more trials with smaller block designs than in a larger block design. 

There is a difference in the design efficiency when testing for A-B vs. A-C. The normal standard deviation for A-B is always less than that for A-C for all the block times (t=20, 50, 100).

This is probably because the number of times that C is consecutive with A is less than when B is consecutive with A. Given the order "ABC", A and B are consecutive every time we run through the cycle. However, the order "CA" only occurs when we end one cycle and start another. Thus, when t=20, there are 5 times in which A and B are consecutive but only 4 times in which A and C are consecutive. When t=20, there are 2 times in which A and B are consecutive, but only 1 time when A and C are consecutive. When t=50, there is 1 time in which A and B are consecutive, but no times when A and C are consecutive. This would reflect the reason why the normal standard deviation for A-B is always less than that for A-C regardless of block time.

#Q6
--
##Using a block duration of 50 seconds, change the value of the `-polort` `3dD3convolve` option to 2, 6, and 12 and compare the efficiency of these three cases. What do you think the -polort option does and why does this change the efficiency? Would the same pattern emerge for a block duration of 20 seconds?

The efficiency for the different `-polort` values are as follows:

`-polort 1`

>Stimulus: A 
>  h[ 0] norm. std. dev. =   0.1000
>
>Stimulus: B 
>  h[ 0] norm. std. dev. =   0.1006
>
>Stimulus: C 
>  h[ 0] norm. std. dev. =   0.1029
>
>General Linear Test: GLT#1  
>  LC[0] norm. std. dev. =   0.0298 
>
>General Linear Test: GLT#2  
>  LC[0] norm. std. dev. =   0.0325 
>
>0.03115

`-polort 2`

>Stimulus: A 
>  h[ 0] norm. std. dev. =   0.1057
>
>Stimulus: B 
>  h[ 0] norm. std. dev. =   0.1077
>
>Stimulus: C 
>  h[ 0] norm. std. dev. =   0.1086
>
>General Linear Test: GLT#1  
>  LC[0] norm. std. dev. =   0.0300 
>
>General Linear Test: GLT#2  
>  LC[0] norm. std. dev. =   0.0325 
>
>0.03125

`-polort 6`

>Stimulus: A 
>  h[ 0] norm. std. dev. =   0.1889
>
>Stimulus: B 
>  h[ 0] norm. std. dev. =   0.1755
>
>Stimulus: C 
>  h[ 0] norm. std. dev. =   0.1889
>  
>General Linear Test: GLT#1  
>  LC[0] norm. std. dev. =   0.0605 
>
>General Linear Test: GLT#2  
>  LC[0] norm. std. dev. =   0.0577 
>
>0.0591

`-polort 12`

>Stimulus: A 
>  h[ 0] norm. std. dev. =   0.5427
>
>Stimulus: B 
>  h[ 0] norm. std. dev. =   0.5574
>
>Stimulus: C 
>  h[ 0] norm. std. dev. =   0.5633
>
>General Linear Test: GLT#1  
>  LC[0] norm. std. dev. =   0.0981 
>
>General Linear Test: GLT#2  
>  LC[0] norm. std. dev. =   0.0972 
>
>0.09765

It looks like the design efficiency from most to least efficient is `-polort 1`, `-polort 2`, `-polort 6`, `-polort 12` by looking at the efficiency from `efficiency_parser.py` as well as the normal standard deviation for each comparison (since lower numbers are better).

I am not sure what `-polort` would do, but the program almost always suggests that `-polort` value should be 3 or more. So, if it doesn't improve design efficiency, it may improve the colinearity. In the first lines, we want the value to be closer to 1. In that case, we find that the values for each stimulus is closer to 1 for higher `-polort` values. 

If `-polort` increases colinearity, then this would increase the variance and increase the standard errors for the contrasts of interest (A-B and A-C), which explains why higher `-polort` values lead to less design efficiency. 

If `-polort` only increases colinearity, then it should not matter what t value for the block design we have: it should always increase colinearity, so it would always increase the variance and standard errors for the contrasts of interest, so the same pattern should emerge if t=20. 

#Q7
--
##You want to design an experiment that contrasts 2 different visual conditions. In general terms, what is the best design for this experiment? Why?

In general, the block design would be best for a contrast between 2 different visual conditions. This is because the block design maximizes the difference between active vs. rest comparison and, since there are only two conditions, the characteristic frequency would be the stimuli characteristic frequency divided by 2 (like on slide 66) since every change in block contrasts the two conditions (alternating the condition). 

#Q8
--
##You want to design an experiment that contrasts 7 different visual conditions. In general terms, what is the best design for this experiment? Why?

In general, an event-related design would be better than a block design in contrasting 7 different conditions. This is because the design frequency would be very low compared to the stimuli characteristic frequency. Also, if we want the contrasting conditions to be consecutive, there are 21 different pairwise comparisons we need for 7 different conditions, so to get all pairwise contrasts in a block design more than once, the run time would be very long. So a block design would be inefficient for 7 different visual conditions. 

Finally, since slow event-related designs are not very efficient, it would probably be best to use a rapid event-related design. 


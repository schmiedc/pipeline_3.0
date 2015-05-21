#!/bin/bash

source ../../master_3.2.sh

mkdir -p $jobs_resaving

for i in $parallel_timepoints

do
	for a in $angle_prep
	do
		job="$jobs_resaving_ometiff/resave-$i-$a.job"
		echo $job
		echo "$XVFB_RUN -a $Fiji \
		-Ddir=$image_file_directory \
		-Dtimepoint=$i \
		-Dangle=$a \
		-Dpad=$pad \
		-- --no-splash $resaving_ometiff" >> "$job"
		chmod a+x "$job"
	done
done

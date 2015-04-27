#!/bin/bash

# master file path
source /projects/pilot_spim/Christopher/pipeline_3.0/master_3.1

# calculation of hdf5 partitions
num_timepoints=`echo ${parallel_timepoints} | wc -w` 	# counts number of 
							# timepoints to 
							# calcluate numbers of 
							# partitions
# creates jobs for hdf5 resave job 0 is creating always .xml file							
for i in `seq 0 $num_timepoints`			# starts partitions 
							# setting always at one
						
do

	job="$jobs_export/hdf5-$i.job"
	echo $job 
	echo "#!/bin/bash" > "$job"
	echo "$XVFB_RUN -a $Fiji -Xmx10g \
		-Dimage_file_directory=$image_file_directory \
		-Dxml_filename=$xml_filename \
		-Dresave_angle=$resave_angle \
		-Dresave_channel=$resave_channel \
		-Dresave_illumination=$resave_illumination \
		-Dresave_timepoint=$resave_timepoint \
		-Dsubsampling_factors=$subsampling_factors \
		-Dhdf5_chunk_sizes=$hdf5_chunk_sizes \
		-Dtimepoints_per_partition=$timepoints_per_partition \
		-Dsetups_per_partition=$setups_per_partition \
		-Drun_only_job_number=$i \
			-- --no-splash $export" >> "$job"
	chmod a+x "$job"
done



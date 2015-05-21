#!/bin/bash

# master file path
source ../../master_3.1.sh

# calculation of hdf5 partitions
num_timepoints=`echo ${parallel_timepoints} | wc -w` 	# counts number of
							# timepoints to
							# calcluate numbers of
							# partitions
# creates jobs for hdf5 resave job 0 is creating always .xml file
for i in `seq 0 $num_timepoints`			# starts partitions
							# setting always at one

do

	job="$output_jobs_export/hdf5-deco-$i.job"
	echo $job 
	echo "#!/bin/bash" > "$job"
	echo "$XVFB_RUN -a $Fiji -Xmx10g \
		-Dimage_file_directory=$deco_file_directory \
		-Dfirst_xml_filename=$deco_xml \
		-Dhdf5_xml_filename=$deco_hdf5_xml \
		-Dresave_angle=$resave_angle \
		-Dresave_channel=$resave_channel \
		-Dresave_illumination=$resave_illumination \
		-Dresave_timepoint=$resave_timepoint \
		-Dsubsampling_factors=$subsampling_factors \
		-Dhdf5_chunk_sizes=$hdf5_chunk_sizes \
		-Dtimepoints_per_partition=$timepoints_per_partition \
		-Dsetups_per_partition=$setups_per_partition \
		-Drun_only_job_number=$i \
		-Dconvert_32bit=$convert_32bit \
			-- --no-splash $deco_output_export" >> "$job"
	chmod a+x "$job"
done



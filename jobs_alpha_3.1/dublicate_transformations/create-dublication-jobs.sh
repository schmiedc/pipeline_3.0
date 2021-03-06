#!/bin/bash
source ../../master_3.3.sh

mkdir -p $jobs_dublication

job="$jobs_dublication/dublicate.job"
echo $job
echo "#!/bin/bash" > "$job"
echo "$XVFB_RUN -a $Fiji \
	-Dimage_file_directory=$image_file_directory \
	-Dmerged_xml=$merged_xml \
	-Dprocess_timepoint_timelapse=$process_timepoint_timelapse \
	-Dprocess_illumination=$reg_process_illumination \
	-Dprocess_angle=$reg_process_angle \
	-Dsource_dublication=$source_dublication \
	-Dtarget_dublication=$target_dublication \
	-Dduplicate_which_transformations=$duplicate_which_transformations \
        -- --no-splash $dublicate_transformations" >> "$job"

chmod a+x "$job"

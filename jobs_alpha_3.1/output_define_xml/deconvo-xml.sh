#!/bin/bash

# path of master file
source ../../master_3.3.sh

# creates directory for job files if not present
mkdir -p $deco_jobs_xml

# creates job for defining dataset
job="$deco_jobs_xml/xml_deconvo.job"
echo $job
echo "#!/bin/bash" > "$job"
echo "$XVFB_RUN -a $Fiji \
	-Dimage_file_directory=$deco_file_directory \
	-Dtimepoints=$deco_timepoints \
	-Dchannels=$deco_channels \
	-Dimage_file_pattern=$deco_image_file_pattern \
	-Dpixel_distance_x=$deco_pixel_distance_x \
	-Dpixel_distance_y=$deco_pixel_distance_y \
	-Dpixel_distance_z=$deco_pixel_distance_z \
	-Dpixel_unit=$deco_pixel_unit \
	-Dxml_filename=$deco_xml \
	-Dtype_of_dataset=$deco_type_of_dataset \
	-Dmultiple_timepoints=$deco_multiple_timepoints \
	-Dmultiple_channels=$deco_multiple_channels \
	-Dmultiple_illumination_directions=$deco_multiple_illumination_directions \
	-Dmultiple_angles=$deco_multiple_angles \
	-Dimglib_container=$deco_imglib_container \
		-- --no-splash $deco_xml_script" >> "$job"
chmod a+x "$job"


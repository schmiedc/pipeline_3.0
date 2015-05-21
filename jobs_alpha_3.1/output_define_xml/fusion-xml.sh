#!/bin/bash

# path of master file
source ../../master_3.1.sh

# creates directory for job files if not present
mkdir -p $fused_jobs_xml

# creates job for defining dataset
job="$fused_jobs_xml/xml_fusion.job"
echo $job
echo "#!/bin/bash" > "$job"
echo "$XVFB_RUN -a $Fiji \
	-Dimage_file_directory=$fused_file_directory \
	-Dtimepoints=$fused_timepoints \
	-Dchannels=$fused_channels \
	-Dimage_file_pattern=$fused_image_file_pattern \
	-Dpixel_distance_x=$fused_pixel_distance_x \
	-Dpixel_distance_y=$fused_pixel_distance_y \
	-Dpixel_distance_z=$fused_pixel_distance_z \
	-Dpixel_unit=$fused_pixel_unit \
	-Dxml_filename=$fused_xml \
	-Dtype_of_dataset=$fused_type_of_dataset \
	-Dmultiple_timepoints=$fused_multiple_timepoints \
	-Dmultiple_channels=$fused_multiple_channels \
	-Dmultiple_illumination_directions=$fused_multiple_illumination_directions \
	-Dmultiple_angles=$fused_multiple_angles \
	-Dimglib_container=$fused_imglib_container \
		-- --no-splash $fused_xml_script" >> "$job"
chmod a+x "$job"


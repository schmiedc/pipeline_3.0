#!/bin/bash

# path of master file
source ../../master_3.3.sh

# creates directory for job files if not present
mkdir -p $jobs_xml

# creates job for defining dataset
job="$jobs_xml/xml_tif.job"
echo $job
echo "#!/bin/bash" > "$job"
echo "$XVFB_RUN -a $Fiji \
	-Dimage_file_directory=$image_file_directory \
	-Dtimepoints=$timepoints \
	-Dchannels=$channels \
	-Dangles=$angles \
	-Dimage_file_pattern=$image_file_pattern \
	-Dpixel_distance_x=$pixel_distance_x \
	-Dpixel_distance_y=$pixel_distance_y \
	-Dpixel_distance_z=$pixel_distance_z \
	-Dpixel_unit=$pixel_unit \
	-Dxml_filename=$first_xml_filename \
	-Dtype_of_dataset=$type_of_dataset \
	-Dmultiple_timepoints=$multiple_timepoints \
	-Dmultiple_channels=$multiple_channels \
	-Dillumination=$illumination \
	-Dmultiple_illumination_directions=$multiple_illumination_directions \
	-Dmultiple_angles=$multiple_angles \
	-Dimglib_container=$imglib_container \
		-- --no-splash $define_tif_xml" >> "$job"
chmod a+x "$job"


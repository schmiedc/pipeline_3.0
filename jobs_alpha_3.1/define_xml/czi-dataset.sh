#!/bin/bash

# path of master file
source ../../master_3.2.sh

# creates directory for job files if not present
mkdir -p $jobs_xml

# creates job for defining dataset
job="$jobs_xml/xml_czi.job"
echo $job
echo "#!/bin/bash" > "$job"
echo "$XVFB_RUN -a $Fiji \
        -Dimage_file_directory=$image_file_directory \
        -Dfirst_czi=$first_czi \
        -Dangles=$angles \
        -Dchannels=$channels \
        -Dillumination=$illumination \
        -Drotation_around=$rotation_around \
        -Dpixel_distance_x=$pixel_distance_x \
        -Dpixel_distance_y=$pixel_distance_y \
        -Dpixel_distance_z=$pixel_distance_z \
        -Dpixel_unit=$pixel_unit \
        -Dfirst_xml_filename=$first_xml_filename \
		-- --no-splash $define_czi_xml" >> "$job"
chmod a+x "$job"

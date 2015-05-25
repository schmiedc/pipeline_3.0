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
        -Dangle_number=$angle_number \
        -Dangle_1=$angle_1 \
        -Dangle_2=$angle_2 \
        -Dangle_3=$angle_3 \
        -Dangle_4=$angle_4 \
        -Dangle_5=$angle_5 \
        -Dangle_6=$angle_6 \
        -Dangle_7=$angle_7 \
        -Dangle_8=$angle_8 \
        -Dangle_9=$angle_9 \
        -Dangle_10=$angle_10 \
        -Dangle_11=$angle_11 \
        -Dangle_12=$angle_12 \
        -Dchannel_number=$channel_number \
        -Dchannel_1=$channel_1 \
        -Dchannel_2=$channel_2 \
        -Dchannel_3=$channel_3 \
        -Dchannel_4=$channel_4 \
        -Dchannel_5=$channel_5 \
        -Dillum_number=$illum_number \
        -Dillumination_1=$illumination_1 \
        -Dillumination_2=$illumination_2 \
        -Drotation_around=$rotation_around \
        -Dpixel_distance_x=$pixel_distance_x \
        -Dpixel_distance_y=$pixel_distance_y \
        -Dpixel_distance_z=$pixel_distance_z \
        -Dpixel_unit=$pixel_unit \
        -Dfirst_xml_filename=$first_xml_filename \
		-- --no-splash $define_czi_xml" >> "$job"
chmod a+x "$job"

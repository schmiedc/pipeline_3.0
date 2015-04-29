#!/bin/bash

# path of master file
source /projects/pilot_spim/Christopher/pipeline_3.0/master_3.1

# creates directory for job files if not present
mkdir -p $jobs_xml

# creates job for defining dataset
job="$jobs_xml/xml_czi.job"
echo $job
echo "#!/bin/bash" > "$job"
echo "$XVFB_RUN -a $Fiji \
        -Dimage_file_directory=$image_file_directory \
        -Dfirst_czi=$first_czi \
        -Dangle_1=$angle_1 \
        -Dangle_2=$angle_2 \
        -Dangle_3=$angle_3 \
        -Dangle_4=$angle_4 \
        -Dangle_5=$angle_5 \
        -Dchannel_1=$channel_1 \
        -Dchannel_2=$channel_2 \
        -Dillumination_1=$illumination_1 \
        -Drotation_around=$rotation_around \
        -Dpixel_distance_x=$pixel_distance_x \
        -Dpixel_distance_y=$pixel_distance_y \
        -Dpixel_distance_z=$pixel_distance_z \
        -Dpixel_unit=$pixel_unit \
        -Dxml_filename=$xml_filename \
                -- --no-splash $define_czi_xml" >> "$job"
chmod a+x "$job"
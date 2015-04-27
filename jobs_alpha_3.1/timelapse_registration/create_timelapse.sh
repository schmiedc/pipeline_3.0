#!/bin/bash
source /projects/pilot_spim/Christopher/pipeline_3.0/master_3.0

mkdir -p $jobs_timelapse

job="$jobs_timelapse/timelapse.job"
echo $job
echo "#!/bin/bash" > "$job"
echo "$XVFB_RUN -a $Fiji \
    -Dimage_file_directory=$image_file_directory \
    -Dmerged_xml=$merged_xml \
    -Dtimelapse_process_timepoints=$timelapse_process_timepoints \
    -Dprocess_channel_timelapse=$reg_process_channel \
    -Dprocess_illumination=$reg_process_illumination \
    -Dprocess_angle=$reg_process_angle \
    -Dreference_timepoint=$reference_timepoint \
    -Dchannel_1=$channel_1 \
    -Dchannel_2=$channel_2 \
    -Dtype_of_registration_timelapse=$type_of_registration_timelapse \
    -Dregistration_algorithm=$registration_algorithm \
    -Dreg_1_interest_points_channel=$reg_1_interest_points_channel \
    -Dreg_2_interest_points_channel=$reg_2_interest_points_channel \
    -Dtransformation_model=$transformation_model \
    -Dmodel_to_regularize_with=$model_to_regularize_with \
    -Dlambda=$lambda \
    -Dallowed_error_for_ransac=$allowed_error_for_ransac \
    -Dsignificance=$significance \
        -- --no-splash $timelapse_registration" >> "$job"

chmod a+x "$job"


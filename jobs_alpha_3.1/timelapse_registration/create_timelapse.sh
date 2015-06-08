#!/bin/bash
source ../../master_3.3.sh

mkdir -p $jobs_timelapse

job="$jobs_timelapse/timelapse.job"
echo $job
echo "#!/bin/bash" > "$job"
echo "$XVFB_RUN -a $FijiDualTimelapse \
    -Dimage_file_directory=$image_file_directory \
    -Dmerged_xml=$merged_xml \
    -Dtimelapse_process_timepoints=$timelapse_process_timepoints \
    -Dreg_process_channel=$reg_process_channel \
    -Dreg_process_illumination=$reg_process_illumination \
    -Dreg_process_angle=$reg_process_angle \
    -Dreference_timepoint=$reference_timepoint \
    -Dchannels=$channels \
    -Dtype_of_registration_timelapse=$type_of_registration_timelapse \
    -Dregistration_algorithm=$registration_algorithm \
    -Dreg_interest_points_channel=$reg_interest_points_channel \
    -Dtransformation_model=$transformation_model \
    -Dmodel_to_regularize_with=$model_to_regularize_with \
    -Dlambda=$lambda \
    -Dallowed_error_for_ransac=$allowed_error_for_ransac \
    -Dsignificance=$significance \
        -- --no-splash $timelapse_registration" >> "$job"

chmod a+x "$job"


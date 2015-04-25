#!/bin/bash
source /projects/pilot_spim/Christopher/pipeline_3.0/master_3.0
 
mkdir -p $jobs_registration
 
for parallel_timepoints in $parallel_timepoints
 
do
    job="$jobs_registration/register-$parallel_timepoints.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    echo "$XVFB_RUN -a $Fiji \
    	-Dparallel_timepoints=$parallel_timepoints \
    	-Dimage_file_directory=$image_file_directory \
	-Dxml_filename=$xml_filename \
	-Dprocess_timepoint=$reg_process_timepoint \
	-Dprocess_channel=$reg_process_channel \
	-Dprocess_illumination=$reg_process_illumination \
	-Dprocess_angle=$reg_process_angle \
	-Dprocessing_channel=$reg_processing_channel \
	-Dlabel_interest_points=$label_interest_points \
	-Dtype_of_registration=$type_of_registration \
        -Dtype_of_detection=$type_of_detection \
        -Dsubpixel_localization=$subpixel_localization \
	-Dimglib_container=$imglib_container \
	-Dreg_1_radius_1=$reg_1_radius_1 \
	-Dreg_1_radius_2=$reg_1_radius_2 \
        -Dreg_1_threshold=$reg_1_threshold \
	-Dinitial_sigma=$initial_sigma \
        -Dthreshold_gaussian=$threshold_gaussian \
	-Dregistration_algorithm=$registration_algorithm \
	-Dreg_1_interest_points_channel=$reg_1_interest_points_channel \
	-Dreg_2_interest_points_channel=$reg_2_interest_points_channel \
	-Dfix_tiles=$fix_tiles \
	-Dmap_back_tiles=$map_back_tiles \
	-Dtransformation_model=$transformation_model \
	-Dmodel_to_regularize_with=$model_to_regularize_with \
	-Dlambda=$lambda \
	-Dallowed_error_for_ransac=$allowed_error_for_ransac \
	-Dsignificance=$significance \
        	-- --no-splash $registration" >> "$job"
    chmod a+x "$job"
done

# Obsolet
# -Ddetection_min_max=$detection_min_max \
# -Dchannel_1_name=$channel_1_name \
# -Dchannel_2_name=$channel_2_name \

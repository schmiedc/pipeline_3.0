#!/bin/bash
source ../../master_3.2.sh

mkdir -p $jobs_registration

for parallel_timepoints in $parallel_timepoints

do
    job="$jobs_registration/register-$parallel_timepoints.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    echo "$XVFB_RUN -a $Fiji \
    	-Dparallel_timepoints=$parallel_timepoints \
    	-Dimage_file_directory=$image_file_directory \
	-Dxml_filename=$hdf5_xml_filename \
	-Dreg_process_timepoint=$reg_process_timepoint \
	-Dreg_process_channel=$reg_process_channel \
	-Dreg_process_illumination=$reg_process_illumination \
	-Dreg_process_angle=$reg_process_angle \
	-Dprocessing_channel=$reg_processing_channel \
	-Dchannel_number=$channel_number \
	-Dchannel_1=$channel_1 \
	-Dchannel_2=$channel_2 \
	-Dlabel_interest_points=$label_interest_points \
	-Dtype_of_registration=$type_of_registration \
        -Dtype_of_detection=$type_of_detection \
        -Dsubpixel_localization=$subpixel_localization \
	-Dimglib_container=$imglib_container \
	-Dreg_1_radius_1=$reg_1_radius_1 \
	-Dreg_1_radius_2=$reg_1_radius_2 \
        -Dreg_1_threshold=$reg_1_threshold \
        -Dreg_2_radius_1=$reg_2_radius_1 \
	-Dreg_2_radius_2=$reg_2_radius_2 \
        -Dreg_2_threshold=$reg_2_threshold \
        -Dreg_3_radius_1=$reg_3_radius_1 \
	-Dreg_3_radius_2=$reg_3_radius_2 \
        -Dreg_3_threshold=$reg_3_threshold \
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


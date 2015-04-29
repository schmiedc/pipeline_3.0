#!/bin/bash
source /projects/pilot_spim/Christopher/pipeline_3.0/master_3.1

mkdir -p $jobs_external_transformation	
	
	job="$jobs_external_transformation/external_transformation.job"
	echo $job
	echo "#!/bin/bash" > "$job"
	echo "$XVFB_RUN -a $Fiji \
		-Dimage_file_directory=$image_file_directory \
		-Dmerged_xml=$merged_xml \
		-Dtransform_angle=$transform_angle \
		-Dtransform_channel=$transform_channel \
		-Dtransform_illumination=$transform_illumination \
		-Dtransform_timepoint=$transform_timepoint \
		-Dtransformation=$transformation \
		-Dapply_transformation=$apply_transformation \
		-Ddefine_mode_transform=$define_mode_transform \
		-Dmatrix_transform=$matrix_transform \
			-- --no-splash $external_transformation" >> "$job"
	chmod a+x "$job"


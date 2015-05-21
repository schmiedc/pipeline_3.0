#!/bin/bash
source ../../master_3.1.sh

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
		-Dchannel_1=$channel_1 \
		-Dchannel_2=$channel_2 \
		-Dtransformation=$transformation \
		-Dapply_transformation=$apply_transformation \
		-Ddefine_mode_transform=$define_mode_transform \
		-Dmatrix_transform=$matrix_transform \
			-- --no-splash $external_transformation" >> "$job"
	chmod a+x "$job"



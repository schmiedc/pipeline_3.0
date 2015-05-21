#!/bin/bash
source ../../master_3.1.sh

mkdir -p $jobs_deconvolution

for parallel_timepoints in $parallel_timepoints
do
	job="$jobs_deconvolution/deconvolution-$parallel_timepoints.job"
	echo $job
	echo "#!/bin/bash" > "$job"
	echo "$XVFB_RUN -a $Fiji_Deconvolution -Xms50g -Xmx50g \
	-Dimage_file_directory=$image_file_directory \
	-Dmerged_xml=$merged_xml \
	-Dparallel_timepoints=$parallel_timepoints \
	-Dprocess_timepoint=$process_timepoint \
	-Dprocess_channel=$process_channel \
	-Dprocess_illumination=$process_illumination \
	-Dprocess_angle=$process_angle \
	-Dchannel_1=$channel_1 \
	-Dchannel_2=$channel_2 \
	-Dminimal_x_deco=$minimal_x_deco \
	-Dminimal_y_deco=$minimal_y_deco \
	-Dminimal_z_deco=$minimal_z_deco \
	-Dmaximal_x_deco=$maximal_x_deco \
	-Dmaximal_y_deco=$maximal_y_deco \
	-Dmaximal_z_deco=$maximal_z_deco \
	-Dimglib2_container_deco=$imglib2_container_deco \
	-Dtype_of_iteration=$type_of_iteration \
	-Dosem_acceleration=$osem_acceleration \
	-DTikhonov_parameter=$Tikhonov_parameter \
	-Dcompute=$compute \
	-Dpsf_estimation=$psf_estimation \
	-Ddeco_output_file_directory=$deco_output_file_directory \
	-Dcuda_directory=$cuda_directory \
	-Ddetections_to_extract_psf_for_channel_1=$detections_to_extract_psf_for_channel_1 \
	-Ddetections_to_extract_psf_for_channel_2=$detections_to_extract_psf_for_channel_2 \
	-Dpsf_size_x=$psf_size_x \
	-Dpsf_size_y=$psf_size_y \
	-Dpsf_size_z=$psf_size_z \
	-Diterations=$iterations \
	-- --no-splash $deconvolution" >> "$job"
	chmod a+x "$job"
done



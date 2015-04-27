#!/bin/bash
source /projects/pilot_spim/Christopher/pipeline_3.0/master_3.0
 
mkdir -p $jobs_fusion

for parallel_timepoints in $parallel_timepoints
 
do
    job="$jobs_fusion/fusion-$parallel_timepoints.job"
    echo $job
    echo "#!/bin/bash" > "$job"
    echo "$XVFB_RUN -a $Fiji \
    	-Dimage_file_directory=$image_file_directory \
    	-Dparallel_timepoints=$parallel_timepoints \
    	-Dmerged_xml=$merged_xml \
    	-Dprocess_timepoint=$process_timepoint \
    	-Dprocess_channel=$process_channel \
    	-Dprocess_illumination=$process_illumination \
    	-Dprocess_angle=$process_angle \
    	-Dxml_output=$xml_output \
    	-Dfused_image=$fused_image \
    	-Dminimal_x=$minimal_x \
    	-Dminimal_y=$minimal_y \
    	-Dminimal_z=$minimal_z \
    	-Dmaximal_x=$maximal_x \
    	-Dmaximal_y=$maximal_y \
    	-Dmaximal_z=$maximal_z \
    	-Ddownsample=$downsample \
    	-Dpixel_type=$pixel_type \
    	-Dimglib2_container_fusion=$imglib2_container_fusion \
    	-Dprocess_views_in_paralell=$process_views_in_paralell \
    	-Dinterpolation=$interpolation \
    	-Dimglib2_data_container=$imglib2_data_container \
    	-Dsubsampling_factors=$subsampling_factors \
    	-Dhdf5_chunk_sizes=$hdf5_chunk_sizes \
    	-Dtimepoints_per_partition=$timepoints_per_partition \
    	-Dsetups_per_partition=$setups_per_partition \
    		-- --no-splash $fusion" >> "$job"
    chmod a+x "$job"
done


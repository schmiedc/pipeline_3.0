#!/bin/bash

source ../../master_3.3.sh

job="$jobs_xml_merge/merge.job"
echo $job
echo "#!/bin/bash" > "$job"
echo "$XVFB_RUN -a $Fiji \
	-Dimage_file_directory=$image_file_directory \
	-Dmerged_xml=$merged_xml \
		-- --no-splash $xml_merge" >> "$job"
chmod a+x "$job"

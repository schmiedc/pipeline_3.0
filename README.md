Supported datasets: The whole or parts of a multi view time-lapse can be processed but this part needs to be continuous. Currently all angles are processed.

ImageJ Opener (resave to .tif):

    Multiple timepoints: YES (one file per timepoint)
    Multiple channels: NO (one channel)
    Multiple illumination directions: No (one illumination direction)
    Multiple angles: YES one file per angle

Zeiss Lightsheet Z.1 Dataset (LOCI): currently for 5 angle data set but can easily be adjusted

    Multiple timepoints: YES (one file per timepoint)
    Multiple channels: NO (one channel)
    Multiple illumination directions: NO (one illumination direction)
    Multiple angles: YES (one file per angle)

Resave as .zip (Compression) gives a compression factor of 1.7x.
CPU time for compression was about 80sec .
CPU time for resave to .tif was about 22sec.

GPU Deconvolution 10 Iterations 2x downsampled takes 1h 10min for 1 time point.
There are 4 nodes available for GPU processing.
Compare processing to CPU Deconvolution. 

Supported datasets: Whole or parts of a multi-view time-lapse can be processed but parts need to be continuous. Currently all angles are processed.

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
CPU time for compression was about 80sec.
CPU time for resave to .tif was about 22sec.

Resaving as hdf5 comes with compression factor of 1.5x
CPU time of 3 min

GPU Deconvolution 10 Iterations 2x downsampled with cropping: about 14 min for 1 time point.
There are 4 nodes available for GPU processing. GPU queue has high priority and was very fast on the queue.
CPU Deconvolution 10 Iterations 2x downsampled with cropping: about 47 min for 1 time point.
Uses one entire node and its entire memory. Takes time until it gets to the node. GPU should pay of if you have less than 13 nodes available at the same time. 



The scripts are now supporting multiple angles, multiple channels and multiple illumination direction without adjusting the .bsh or creat-jobs.sh scripts.

Based on SPIM registration version 3.3.8

Supported datasets are in the following format:

ImageJ Opener (resave to .tif):

    Multiple timepoints: YES (one file per timepoint)
    Multiple channels: YES (one file per channel)
    Multiple illumination directions: YES (one file per illumination direction) => not tested yet
    Multiple angles: YES one file per angle

Zeiss Lightsheet Z.1 Dataset (LOCI)

    Multiple timepoints: Supports multiple time points per file
    Multiple channels: Supports multiple channels per file
    Multiple illumination directions: YES (one file per illumination direction)
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

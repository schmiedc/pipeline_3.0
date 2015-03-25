# pipeline_3.0

PROBLEM: Channel name currently fixed to 0! Affects registration, fusion, external transformation etc…

PROBLEM: Fusion and Deconvolution write .tif files but not into hdf5 nor are they able to write .xml files. Access to the data via BigDataViewer not possible yet. -> will be addressed

BUG: Deconvolution searches the libraries in the output_file_directory instead of the specified directory_cuda. 



STARTED: New clean masterfile:

STARTED: Deconvolution



TODO: 2 Channel processing > only one channel contains the beads or both channel contain the beads

TODO: Documentation

TODO: Compression >> Collect ideas

TODO: Automation >> Collect ideas

TODO: GUI >> Collect ideas 
	Define dataset: load first file via Fiji locally. 
	Takes a while. Need to figure out how to access the server graphically on CentOS. 



DONE: define .xml file for ImageJ Opener

DONE: define .xml file for L.Z1 Opener 

DONE: define .xml file for LOCI

DONE: detection and registration

DONE: bug in registration.bsh > .job.xml is hardcoded in there needs to be conditional

DONE: time-lapse registration: done >> needs merged .xml files

DONE: Fusion stop gap solution
	fusion is missing many parameters
	writes .tif files but no .xml files or not to hdf5 files
	is not supporting BigDataViewer at the moment
	Will be addressed on the level of the plugin. 

DONE: hdf5 export

DONE: Renaming

DONE: Resaving of .czi to .tif 

DONE: Resaving of .czi to .zip => One type of compression

DONE: Resaving of me.tiff to .tif

DONE: apply external transformation

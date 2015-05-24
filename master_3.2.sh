#!/bin/bash
#===============================================================================
#
#	  FILE: master
#
#  DESCRIPTION: source file for cluster processing scripts
#
#       AUTHOR: Christopher Schmied, schmied@mpi-cbg.de
#    INSTITUTE: Max Planck Institute for Molecular Cell Biology and Genetics
#         BUGS:
#        NOTES: Works for Single Channel Data
#		Output file directory is the image file directory
#		Channel name cannot contain spaces
#      Version: 3.2
#      CREATED: 2014-04-02
#     REVISION: 2015-05-21
#===============================================================================

#-------------------------------------------------------------------------------
# Data set description
#
# 	Dataset: Dual Channel test: 2015-02-20_LZ2_Stock48_Stock58.czi
#	  Owner: Christopher Schmied
#  	Created: 2015-05-21
#
# --- Data directory -----------------------------------------------------------
image_file_directory="/projects/pilot_spim/Christopher/Test_pipeline_3.0/Dual_Channel/czi/"

# --- jobs directory -----------------------------------------------------------
job_directory="/projects/pilot_spim/Christopher/pipeline_3.0/jobs_alpha_3.1/"

# --- Number of timepoints in dataset ------------------------------------------
# IMPORTANT for processing .czi files timepoints always start with 0
parallel_timepoints="`seq 0 1`"  # format: "`seq 1 3`"

#===============================================================================
# Preprocessing
#	1) rename .czi files
#	2) resave .czi files into .tif or .zip
#	3) resave ome.tiff files into .tif
#===============================================================================

#-------------------------------------------------------------------------------
# Resaving, Renaming files and Splitting: General
#
# Important: For renaming and resaving .czi files the first .czi file has to
# carry the index (0)
#-------------------------------------------------------------------------------

pad="2"		# for padded zeros
angle_prep="1 2 3 4 5" # angles format: "1 2 3"

#--- Renaming ------------------------------------------------------------------

first_index="0"		# First index of czi files
last_index="9"		# Last index of czi files
first_timepoint="1"	# The first timepoint
angles_renaming=(1 2 3 4 5)	# Angles format: (1 2 3)

source_pattern=2015-02-20_LZ2_Stock48_Stock58\(\{index\}\).czi # Name of .czi files
target_pattern=spim_TL\{timepoint\}_Angle\{angle\}.czi	# The output pattern of renaming

#===============================================================================
# Multiview Reconstruction:
#	1) Define Dataset using .tif or .czi files
#	2) resave hdf5
#	3) Detection and Registration of Interest Points
#	4) Multiview Fusion
#===============================================================================

first_xml_filename="\"Dual_Channel\""           # xml filename for czi or tif dataset without ".xml"

hdf5_xml_filename="\"hdf5_Dual_Channel\""		# xml filename for resaving into hdf5 dataset without ".xml"

merged_xml="\"hdf5_Dual_Channel_merge\"" 	# filename of merged xml without ".xml"

channel_1="green"		# general setting for channel names
channel_2="red"

channel_switch="dual" # or "single"
#-------------------------------------------------------------------------------
# Define dataset: General
#-------------------------------------------------------------------------------

pixel_distance_x="0.2875535786151886" 	# Manual calibration x
pixel_distance_y="0.2875535786151886" 	# Manual calibration y
pixel_distance_z="1.50000" 	# Manual calibration z
pixel_unit="um"			# unit of manual calibration

#--- Define dataset: ImageJ Opener or Image Stacks (LOCI Bioformats) -----------
# Calibration Type = Same voxel-size for all views
# Comment out "channels_=" in define_tif_zip.bsh if single channel

multiple_timepoints="\"YES (one file per time-point)\""    	# or NO (one time-point)
multiple_channels="\"YES (one file per channel)\""			# or "\"NO (one channel)\""
multiple_illumination_directions="\"NO (one illumination direction)\"" 	# or YES (one file per illumination direction)
multiple_angles="\"YES (one file per angle)\"" 			# or NO (one angle)
timepoints="1-2"			# Timepoints format: "1-2"
acquisition_angles="1,2,3,4,5"		# angles format: "1,2,3" or "1-3"
image_file_pattern="spim_TL{tt}_Angle{a}_Channel{c}.tif"	# pattern of spim for padded zeros use tt
channels="0,1"							# for dual channel give spim_TL0{tt}_Angle{a}_Channel{c}.tif

#--- Define dataset: Zeiss Lightsheet Z.1 Dataset (LOCI Bioformats) ------------
# Usable for 5 view datasets 1 channel
# Comment out line: "channel_2=" define_czi.bsh if single channel

first_czi="2015-02-20_LZ2_Stock48_Stock58.czi"
angle_number="5"
angle_1="0"
angle_2="72"
angle_3="144"
angle_4="216"
angle_5="288"
illumination_1="0" 	# For one illumination side = 0
rotation_around="X-Axis"

#-------------------------------------------------------------------------------
# Resave as hdf5
#-------------------------------------------------------------------------------

# Creates new .xml file resave to xml_filename and backup original xml file
# create-export-jobs.sh calculates the number of needed partitions based on
# parallel_timepoints

#-------------------------------------------------------------------------------
# Detection and Registration
#
# Supported Detection: Differnce of Mean on Maximum
#-------------------------------------------------------------------------------
# General parallel processing settings
# Time points are processed in parallel. The time point is specified in the
# job script using the parallel_timepoints variable (see dataset description)

reg_process_timepoint="\"Single Timepoint (Select from List)\""
reg_process_illumination="\"All illuminations\""
reg_process_angle="\"All angles\""

# Channel Settings:
reg_process_channel="\"All channels\""  			# Single Channel
# reg_process_channel="\"Single channel (Select from List)\""  # Dual Channel: 1 Channel contains the beads
reg_processing_channel="\"green\""			# Dual Channel: 1 Channel contains the beads

#--- Detect Interest Points for Registration -----------------------------------

label_interest_points="\"beads\""
type_of_detection="\"Difference-of-Mean (Integral image based)\"" # Difference
reg_1_radius_1="2"							  # of Mean
reg_1_radius_2="3"
reg_1_threshold="0.005"

#--- Register Dataset based on Interest Points ---------------------------------

reg_1_interest_points_channel="\"beads\"" # Dual Channel: Channel does not contain the beads "\"[DO NOT register this channel]\""
reg_2_interest_points_channel="\"beads\""				# Dual Channel: Channel 1 contains the beads

#--- Merge .xml after registration ---------------------------------------------

# Creates merged_xml

#--- timelapse registration ----------------------------------------------------

reference_timepoint="0"	# reference timepoint

#--- Dublicate Transformations -------------------------------------------------

source_dublication="1"
target_dublication="0"

#-------------------------------------------------------------------------------
# Fusion General Settings
#-------------------------------------------------------------------------------

process_timepoint="\"Single Timepoint (Select from List)\""
process_channel="\"All channels\""
process_illumination="\"All illuminations\""
process_angle="\"All angles\""
xml_output="\"Save every XML with user-provided unique id\"" # "\"Do not process on cluster\""
fused_image="\"Append to current XML Project\"" # "\"Save as TIFF stack\""

#--- Multi-view content based fusion -------------------------------------------

minimal_x="128" 	# Cropping parameters of full resolution
minimal_y="-13"
minimal_z="-407"
maximal_x="986"
maximal_y="1927"
maximal_z="498"
downsample="1"

#--- Define xml on content based fusion fusion output and save as xml ----------
# for pixel size take downsampling into account!
fused_file_directory=${image_file_directory}

fused_image_file_pattern="TP{t}_Chgreen_Ill0_Ang0,72,144,216,288.tif"	# pattern of spim for padded zeros use tt
fused_xml="\"fused_Stock68\""
fused_timepoints="0-1"			# Timepoints format: "1-2"
fused_pixel_distance_x="1.150212" 	# Manual calibration x
fused_pixel_distance_y="1.150212" 	# Manual calibration y
fused_pixel_distance_z="1.150212" 	# Manual calibration z
fused_pixel_unit="um"			# unit of manual calibration

fused_hdf5_xml="\"hdf5_fused_Stock68\"" 	# name of hdf5 dataset

#--- External transformation for multi-view deconvolution-----------------------
# Caution! Make copy of .xml file before application of transformation

matrix_transform="\"0.5, 0.0, 0.0, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0, 0.0, 0.5, 0.0\""

#--- Multi-view deconvolution --------------------------------------------------
# Select GPU or CPU processing
# When submitting to deconvolution select correct submit command for GPU or CPU

jobs_deconvolution=${job_directory}"deconvolution"		# directory for deconvolution

# select: "/deconvolution_GPU.bsh" or "/deconvolution_CPU.bsh"
# deconvolution=${jobs_deconvolution}"/deconvolution_CPU.bsh"		# script for CPU deconvolution
deconvolution=${jobs_deconvolution}"/deconvolution_GPU.bsh"		# script for GPU deconvolution

deco_output_file_directory=${image_file_directory} # output directory: make sure it exists!

minimal_x_deco="64" 	# Cropping parameters adjusted for transformation
minimal_y_deco="-6"
minimal_z_deco="-203"
maximal_x_deco="493"
maximal_y_deco="963"
maximal_z_deco="249"

iterations="1"						# Number of iterations

detections_to_extract_psf_for_channel_0="\"beads\""	# type of detection "\"[Same PSF as channel 1]\""
detections_to_extract_psf_for_channel_1="\"beads\""
psf_size_x="19"						# Dimensions of PSF
psf_size_y="19"
psf_size_z="25"

#--- Define xml for deconvolution output and resave into hdf5 ------------------
# for pixel size take downsampling into account!

deco_file_directory=${deco_output_file_directory}

deco_image_file_pattern="TP{t}_Chgreen_Ill0_Ang0,72,144,216,288.tif"	# pattern of spim for padded zeros use tt
deco_xml="\"deco_Stock68\""

deco_timepoints="0-1"			# Timepoints format: "1-2"
deco_pixel_distance_x="0.575107" 	# Manual calibration x
deco_pixel_distance_y="0.575107" 	# Manual calibration y
deco_pixel_distance_z="0.575107" 	# Manual calibration z
deco_pixel_unit="um"			# unit of manual calibration
deco_channels="0,1"								# for dual channel

deco_hdf5_xml="\"hdf5_deconvo_Stock68\"" 	# name of hdf5 dataset

#===============================================================================
# Directories for scripts and advanced settings for processing
#===============================================================================
#-------------------------------------------------------------------------------
# Fiji settings
#-------------------------------------------------------------------------------
XVFB_RUN="/sw/bin/xvfb-run"				 # virtual frame buffer
#Fiji="/sw/users/schmied/packages/2015-03-19_Fiji.app.cuda/ImageJ-linux64" 		        # old Fiji
#Fiji="/sw/users/schmied/packages/2015-04-25_Fiji.app.cuda/ImageJ-linux64"			# Fiji Bug
#Fiji="/sw/users/schmied/packages/2015-05-07_Fiji.app.cuda/ImageJ-linux64"                       # works
Fiji="/sw/users/schmied/packages/2015-05-21_Fiji.app.cuda/ImageJ-linux64"			# woriking Fiji

Fiji_resave="/sw/users/schmied/lifeline/Fiji.app.lifeline2/ImageJ-linux64" 	# Fiji that works for resaving
Fiji_Deconvolution=${Fiji}		# Fiji that works for deconvolution

#-------------------------------------------------------------------------------
# Pre-processing
#-------------------------------------------------------------------------------
#--- Resaving .czi into .tif files----------------------------------------------
jobs_resaving=${job_directory}"czi_resave"  	# directory .czi resaving
resaving=${jobs_resaving}"/resaving.bsh" 	# script .czi resaving
#--- Resaving ome.tiff into .tif files -----------------------------------------
jobs_resaving_ometiff=${job_directory}"ometiff_resave" 	 # directory .ome.tiff resaving
resaving_ometiff=${jobs_resaving_ometiff}"/resaving-ometiff.bsh" # script .ome.tiff resaving
#--- Compress dataset;----------------------------------------------------------
jobs_compress=${job_directory}"compress" 	# directory .czi to .zip resaving
czi_compress=${jobs_compress}"/for_czi.bsh" 	# script .czi to .zip resaving
#--- Split channels-------------------------------------------------------------
jobs_split=${job_directory}"split_channels" 			# directory
split=${jobs_split}"/split.bsh" 				# script
#===============================================================================
# Multiview Reconstruction:
#===============================================================================
#--- General settings ----------------------------------------------------------
subsampling_factors="\"{ {1,1,1}, {2,2,1}, {4,4,1}, {8,8,1} }\""
hdf5_chunk_sizes="\"{ {32,32,4}, {32,32,4}, {16,16,16}, {16,16,16} }\""
timepoints_per_partition="1"
setups_per_partition="0"
#-------------------------------------------------------------------------------
# Define dataset: General
#-------------------------------------------------------------------------------
jobs_xml=${job_directory}"define_xml"		# directory for define data set
define_tif_xml=${jobs_xml}"/define_tif_zip.bsh"	# script for defining .tif data
define_czi_xml=${jobs_xml}"/define_czi.bsh" # script for defining .czi data
#--- Define dataset: ImageJ Opener or Image Stacks (LOCI Bioformats) -----------
# Calibration Type = Same voxel-size for all views
type_of_dataset="\"Image Stacks (ImageJ Opener)\"" 		# raw fileformat
imglib_container="\"ArrayImg (faster)\""			# options:
#-------------------------------------------------------------------------------
# hdf5 export
#
# split_hdf5
# use_deflate_compression
#-------------------------------------------------------------------------------
jobs_export=${job_directory}"hdf5"	# directory for hdf5 export
export=${jobs_export}"/export.bsh" 	# script for hdf5 export

resave_angle="\"All angles\""
resave_channel="\"All channels\""
resave_illumination="\"All illuminations\""
resave_timepoint="\"All Timepoints\""
#-------------------------------------------------------------------------------
#		Detect Interest Points for Registration
#		Register Dataset based on Interest Points
#
# find_maxima
#-------------------------------------------------------------------------------
jobs_registration=${job_directory}"registration"	# directory for registration
registration=${jobs_registration}"/registration.bsh" 	# script for registration

#--- Detect Interest Points for Registration -----------------------------------
# Specify the method for Detection of beads:
# Difference of mean: Comment out Difference of Gaussian in registration.bsh
# Difference of Gaussian: Comment out  in registration.bsh
# type_of_detection="\"Difference-of-Gaussian\""		 		# Difference
# initial_sigma="1.8000"					  		# of Gaussian
# threshold_gaussian="0.0080"
subpixel_localization="\"3-dimensional quadratic fit\""
# detection_min_max="find_maxima" obsolete?

#--- Register Dataset based on Interest Points ---------------------------------
type_of_registration="\"Register timepoints individually\""
transformation_model="Affine"
registration_algorithm="\"Fast 3d geometric hashing (rotation invariant)\""
fix_tiles="\"Fix first tile\""		# "\"Do not fix tiles\""
map_back_tiles="\"Map back to first tile using rigid model\""
model_to_regularize_with="Rigid"
lambda="0.10"
allowed_error_for_ransac="5"
significance="10"
#-------------------------------------------------------------------------------
# merge .xml
#-------------------------------------------------------------------------------
jobs_xml_merge=${job_directory}"xml_merge"	# directory for merge
xml_merge=${jobs_xml_merge}"/xml_merge.bsh"	# script for merge
#-------------------------------------------------------------------------------
# timelapse registration
#
# consider_each_timepoint_as_rigid_unit
#-------------------------------------------------------------------------------
jobs_timelapse=${job_directory}"timelapse_registration" 		# directory for timelapse registration
timelapse_registration=${jobs_timelapse}"/timelapse_registration.bsh" 	# script for timelapse registration

timelapse_process_timepoints="\"All Timepoints\""
type_of_registration_timelapse="\"Match against one reference timepoint (no global optimization)\""
#-------------------------------------------------------------------------------
# Dublicate transformation
#
# One channel to other channels
# Single Channel (Select from List)
#-------------------------------------------------------------------------------
jobs_dublication=${job_directory}"dublicate_transformations"
dublicate_transformations=${jobs_dublication}"/dublicate_channel.bsh"

duplicate_which_transformations="\"Replace all transformations\""
#-------------------------------------------------------------------------------
# Multi-view fusion
#
# Weighted-average fusion
# Define bounding box manually
# with blending
# with content-based fusion
#-------------------------------------------------------------------------------
jobs_fusion=${job_directory}"fusion"	# directory for content based fusion
fusion=${jobs_fusion}"/fusion.bsh" 	# script for content based fusion

pixel_type="\"16-bit unsigned integer\""
imglib2_container_fusion="\"ArrayImg\""
process_views_in_paralell="\"All\""
interpolation="\"Linear Interpolation\""
imglib2_data_container="\"ArrayImg (faster)\""

#--- Define xml on content based fusion fusion output and save as xml ----------

fused_multiple_timepoints="\"YES (one file per time-point)\""   	# or NO (one time-point)
fused_multiple_channels="\"NO (one channel)\""					# or \"YES (one file per channel)\""
fused_multiple_illumination_directions="\"NO (one illumination direction)\"" 	# or YES (one file per illumination direction)
fused_multiple_angles="\"NO (one angle)\"" 					# or NO (one angle)
fused_channels="0,1"								# for dual channel
fused_jobs_xml=${job_directory}"output_define_xml"		# directory for define data set
fused_xml_script=${fused_jobs_xml}"/define_fusion.bsh" # script for defining .czi data
fused_type_of_dataset="\"Image Stacks (ImageJ Opener)\"" 		# raw fileformat
fused_imglib_container="\"ArrayImg (faster)\""

#-------------------------------------------------------------------------------
# External transformation
#
# same_transformation_for_all_timepoints
# same_transformation_for_all_angles
#-------------------------------------------------------------------------------
jobs_external_transformation=${job_directory}"external_transformation" 	# directory for transformation
external_transformation=${jobs_external_transformation}"/transform.bsh" # script for transformation

transform_angle="\"All angles\""
transform_channel="\"All channels\""
transform_illumination="\"All illuminations\""
transform_timepoint="\"All Timepoints\""
transformation="\"Rigid\""
apply_transformation="\"Current view transformations (appends to current transforms)\""
define_mode_transform="\"Matrix\""
#-------------------------------------------------------------------------------
# Multi-view deconvolution
#
# bounding_box=[Define manually]
# fused_image=[Save as TIFF stack]
# use_tikhonov_regularization
# Do not show PSFs
# library_for_cuda=libFourierConvolutionCUDALib.so
# gpu_1
#-------------------------------------------------------------------------------
imglib2_container_deco="\"ArrayImg \""
type_of_iteration="\"Efficient Bayesian - Optimization I (fast, precise)\""
osem_acceleration="\"1 (balanced)\""
Tikhonov_parameter="0.0006"
compute="\"in 512x512x512 blocks\""
compute_on="\"GPU (Nvidia CUDA via JNA)\""
psf_estimation="\"Extract from beads\""
cuda_directory="/sw/users/schmied/packages/2015-05-21_Fiji.app.cuda/lib/"

#--- Define xml for deconvolution output and resave into hdf5 ------------------
deco_multiple_timepoints="\"YES (one file per time-point)\""   	# or NO (one time-point)
deco_multiple_channels="\"NO (one channel)\""					# or \"YES (one file per channel)\""
deco_multiple_illumination_directions="\"NO (one illumination direction)\"" 	# or YES (one file per illumination direction)
deco_multiple_angles="\"NO (one angle)\"" 					# or NO (one angle)
deco_channels="0,1"								# for dual channel
deco_jobs_xml=${job_directory}"output_define_xml"		# directory for define data set
deco_xml_script=${deco_jobs_xml}"/define_deconvo.bsh" # script for defining .czi data
deco_type_of_dataset="\"Image Stacks (ImageJ Opener)\"" 		# raw fileformat
deco_imglib_container="\"ArrayImg (faster)\""

#--- Export output of fusion or deconvolution ----------------------------------
output_jobs_export=${job_directory}"output_hdf5"	# directory for hdf5 export
fusion_output_export=${output_jobs_export}"/export_fusion.bsh" 	# script for hdf5 export
deco_output_export=${output_jobs_export}"/export_deco.bsh" 	# script for hdf5 export
# setting for 32Bit files
convert_32bit="\"[Use min/max of first image (might saturate intenities over time)]\""

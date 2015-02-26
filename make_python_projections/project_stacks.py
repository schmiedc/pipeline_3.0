#!/sw/bin/python

import sys, os, glob, math 
#from cv2 import imwrite
#import matplotlib
import numpy as np
from scipy import interpolate
from skimage import io as io
#from PIL import Image
#import skimage.io._plugins.freeimage_plugin as fi

# define parameters
angle_step=np.pi/360/2
vec_steps=10

path='/projects/tribolium/Stefan/15-02-17_VW_inj_GAPYFP+H2Bmcherry_32C_PBS_3min_15h_4angles/output/normalized8bit_900/'
output_path=path + 'projections/'
map_path=output_path+'map/'
file_string='norm_ch0_'

# obtain input argument to set timepoint
if len(sys.argv)>1:
    time=np.int(sys.argv[1])
    print 'processing timepoint: ' + str(time)
elif len(sys.argv)>2:
    print 'too many input arguments...'
    sys.exit()
else:
    print 'no timepoint provided...'
    sys.exit()

#path+=time+'/'
print path
if os.path.exists(output_path):
    print 'output path already exists...'
else:
    print 'output path created...'
    os.makedirs(output_path)
		
if os.path.exists(map_path):
    pass
else:
    os.makedirs(map_path)


#file_list=glob.glob(path+'*ch0*.tif')
#file_list.sort()
#tmp_img=Image.open(file_list[0])
#img_h,img_w=tmp_img.size

#print tmp_img.info()
#print np.shape(np.array(tmp_img))

#stack = np.zeros((img_h,img_w,len(file_list)),dtype=np.float) # allocate stack
#z=0
#for i in file_list:
#    #image=Image.open(path+file_string+str(time)+'.tif')
#    img=Image.open(i)
#    stack[:,:,z]=np.ndarray(img).astype(np.float)
#    z+=1

# mask_stack=io.MultiImage(path+'mask_from_norm_ch1b_50_th45_er3d_x10_fch0.tif').concatenate() #load background mask as 3D-TIF-Stack


#stack=io.MultiImage(file_list[time]).concatenate()
stack=io.MultiImage(path+file_string+str(time)+'.tif').concatenate()

# stack=stack*mask_stack #convolve with background-mask (if wanted)
stack_h,stack_w,stack_d=np.shape(stack)
num_steps=2*np.pi/angle_step

proj_img=np.zeros([num_steps,stack_w],dtype=np.float)
proj_distmap=np.zeros([num_steps,stack_w],dtype=np.float)
for y in xrange(0,stack_w):
    print str(y)+'/'+str(stack_w)
    my_spline=interpolate.RectBivariateSpline(range(0,stack_h),range(0,stack_d),np.array(stack[:,y,:],dtype=np.float))
    x_idx=0
    for rot in np.linspace(0,2*np.pi,2*np.pi/angle_step):
        vec_len=np.ceil(np.sqrt(np.power(stack_d,2)+np.power(stack_h,2))/2)
        sample_vec=np.linspace(0,vec_len,vec_len*vec_steps)
        query_ray_x=stack_h/2 + np.cos(rot)*sample_vec
        query_ray_y=stack_d/2 + np.sin(rot)*sample_vec
        pxvalues_along_ray=my_spline.ev(query_ray_x,query_ray_y)
        proj_img[x_idx,y]=pxvalues_along_ray.max()
        proj_distmap[x_idx,y]=pxvalues_along_ray.argmax()/vec_steps
        x_idx+=1

img_fname='projection_'+str(time)+'.tif'
map_fname='projection_map_'+str(time)+'.tif'
#img_result=Image.fromarray(proj_img.astype(np.int16))
#map_result=Image.fromarray(proj_distmap.astype(np.int16))
#img_result.save(output_path+img_fname)
#map_result.save(map_path+map_fname)

#fi.write(uint16(proj_img),output_path+img_fname)
#fi.write(uint16(proj_distmap),map_path+map_fname)

io.imsave(output_path+img_fname,np.uint8(proj_img))
io.imsave(map_path+map_fname,np.uint16(proj_distmap))
#imwrite(output_path+img_fname,np.int16(proj_img)) #from cv2
#imwrite(map_path+map_fname,np.int16(proj_distmap)) #from cv2
#cv2.imwrite(map_path+map_fname,uint16(proj_distap/proj_distmap.max()*np.power(2,16)))

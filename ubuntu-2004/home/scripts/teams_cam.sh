#!/bin/bash
# sudo modprobe v4l2loopback exclusive_caps=1 max_buffers=2

#unmount 
# gvfs-mount -u $(gvfs-mount -l | grep -Pwo gphoto2://.*USB_PTP_Camera.*/)
gioMountExists=$(gio mount -l | grep -Pwo gphoto2://.*USB_PTP_Camera.*/)
if [ ! -z "$gioMountExists" ]; then
	echo unmounting camera ptp
	gio mount -u $gioMountExists
else
	echo camera is unmounted
fi


# gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -vf scale=1024:768  -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0
# gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -vf scale=1680:944  -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0

#-- 1/7/2022 -- broke ffmpeg local build
# gphoto2 --stdout --capture-movie | ~/src/__utils/FFmpeg/ffmpeg -i - -vcodec rawvideo -vf scale=1280:720 -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0

## 1/7/2022 works nice
# gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -vf scale=1280:720  -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0



# limit fps 25
v4l2loopback-ctl set-fps 35 /dev/video0

# gphoto2 --stdout --capture-movie | ~/src/__utils/FFmpeg/ffmpeg -i - -vcodec rawvideo -vf scale=1280:720 -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0

# gphoto2 --stdout --capture-movie | ~/src/__utils/FFmpeg/ffmpeg -i - -vcodec rawvideo -vf scale=1024:768 -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0


gphoto2 --stdout --capture-movie | ~/src/__utils/FFmpeg/ffmpeg -hwaccel cuda -c:v mjpeg_cuvid -resize 1280x720 -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0
# gphoto2 --stdout --capture-movie | ./ffmpeg -hwaccel cuda -c:v mjpeg_cuvid -resize 1280x720 -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0


# if fps < 20. Turn off overlay. Uncompressed / lossles compression + fine + L4:3 can push 30 fps.

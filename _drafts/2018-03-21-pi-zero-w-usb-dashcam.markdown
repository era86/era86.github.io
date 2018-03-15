---
layout: post
title: "Building a Simple Raspberry Pi Dashcam"
date: 2018-03-21
comments: true
---

[![](/assets/images/posts/){: .bordered.landing-image.centered }](/assets/images/posts/)

About a year ago, I bought myself a Raspberry Pi Zero W to play with. Recently, I finally had some time to work on it! I could have done any of the millions of projects out there, but I chose to do something really simple, but useful: a Raspberry Pi dashcam.

It's really just a Raspberry Pi video recorder that starts recording on boot. It can be used anywhere, not just on the dash of a car.

## The Hardware

There are three main components of the dashcam: the Pi, the camera, and the SD card.

### Raspberry Pi Zero W

I wanted a device I could easily hide anywhere in my Jeep. Really, any Raspberry Pi would have worked in this situation, they're all pretty small. If I were to do this project again, I'd use a standard Pi 3 instead of the Pi Zero. This is because the Pi Zero only has mini-USB ports. So, I had to buy an adapter for the webcam.

### AUSDOM USB Webcam

The camera I went with was the cheapest, four-star rated USB webcam on Amazon. Nothing special. I chose this over the standard Raspberry Pi camera because I didn't want to deal with routing a ribbon cable in the Jeep.

### Samsung 64GB Micro-SD Card

Video clip segments can take up a lot of space. I planned to use an external harddrive to store them, but the Pi Zero only has one mini-USB port for peripherals (the other is for power). So, I decided to store clips directly on an SD card and handle the space issue with some Python scripting.

## Install Raspbian OS on the SD Card

A Raspberry Pi is just a miniature computer. So, I could have used any light-weight Linux operating system on it. A dashcam is a headless device (no GUI), so I opted for a terminal-only version of Raspbian.

I followed the official [Raspberry Pi docs](https://www.raspberrypi.org/documentation/installation/installing-images/) to install Raspbian on my SD card with Etcher in Ubuntu. It's very straightforward.

## Enable WiFi and SSH in Raspbian

We need to be able to be able access the internet from Raspbian to install third-party tools. It's also very convenient to do Python scripting on the Pi from another computer via SSH. If you'd rather use an external monitor and USB keyboard to operate directly on the device, feel free to skip the SSH part.

I wrote the instructions on enabling WiFi and SSH in Raspbian in [another post]().

## Boot the SD Card

Once everything is set up, we're ready to boot into our Pi and make it record video!

## SSH into Raspbian and Install `ffmpeg`

`ffmpeg` is a commandline utility for converting and streaming video. Since we're running a headless version of Raspbian, we can use `ffmpeg` in our Python scripts to record clips from the USB webcam and save them to the SD card.

We can install it by doing:

{% highlight bash %}
sudo apt-get install ffmpeg
{% endhighlight %}

## Create Python Script to Record Video

The following script operates basic video-recording functionality. To briefly summarize, the script will:

1. Create a folder for our recordings, if it doesn't already exist.
2. Create a folder based on the current time. The current recording will be written here.
3. Call `ffmpeg` from the commandline to begin saving segments of video from the webcam into the new folder.

`record.py`:
{% highlight python %}
#!/usr/bin/env python

import subprocess
import datetime
import os

ROOT_PATH = os.getenv("ROOT_PATH", "/home/pi")
RECORDINGS_PATH = os.getenv("RECORDINGS_PATH", "recordings")
DATE_FMT = "%Y_%m_%d_%H_%M_%S"
SEGMENT_TIME = 30
ENCODING = os.getenv("ENCODING", "copy")

os.mkdir(RECORDINGS_PATH)

new_dir = datetime.datetime.now().strftime(DATE_FMT)
recording_path = os.path.join(ROOT_PATH, RECORDINGS_PATH, new_dir)
os.mkdir(recording_path)

segments_path = os.path.join(recording_path, "%03d.avi")

command = "ffmpeg -i /dev/video0 -c:v {} -an -sn -dn -segment_time {} -f segment {}".format(ENCODING, SEGMENT_TIME, segments_path)

subprocess.call(command, shell=True)
{% endhighlight %}


`ffmpeg` can get really complicated, really fast. I'd take a look at the [documentation](https://www.ffmpeg.org/ffmpeg.html) for a deeper dive into the command, but I'll break it down a bit:

* `-i /dev/video0`: The input USB camera device. This may differ depending on the operating system or number of USB periphals attached.

* `-c:v copy`: Copy the video stream directly from the input device to the output path.

* `-an -sn -dn`: Omit audio, subtitles, and data.

* `-segment_time 30 -f segment %03d.avi`: Break video clips into 30-second segments.

## Create Python Script to Cleanup Old Recordings

Since drive space isn't infinite, we need to replace older recordings with newer ones (if necessary). The following script will do the cleanup _prior_ to recording:

1. Determine how much space is left on the device.
2. If there is less than 25% of space left on the device, we need to do some cleanup.
3. Get all the folders for all the recordings.
4. Find the oldest folder and delete it.

`purge_old_recordings.py`:
{% highlight python %}
#!/usr/bin/env python

import os
import shutil

ROOT_PATH = os.getenv("ROOT_PATH", "/home/pi")
RECORDINGS_PATH = os.getenv("RECORDINGS_PATH", "recordings")
PERCENTAGE_THRESHOLD = 25.0

statvfs = os.statvfs(ROOT_PATH)

free_bytes = statvfs.f_frsize * statvfs.f_bfree
total_bytes = statvfs.f_frsize * statvfs.f_blocks

free_bytes_percentage = ((1.0 * free_bytes) / total_bytes) * 100

if free_bytes_percentage < PERCENTAGE_THRESHOLD:
    recordings_path = os.path.join(ROOT_PATH, RECORDINGS_PATH)
    
    recordings = []
    for dir_name in os.listdir(recordings_path):
        recording_path = os.path.join(recordings_path, dir_name)
        recordings.append((recording_path, os.stat(recording_path).st_mtime))

    recordings.sort(key=lambda tup: tup[1])

    shutil.rmtree(recordings[0][0])
{% endhighlight %}

## Make Raspbian Auto-Run Scripts on Boot

Assuming our scripts are saved in `/home/pi` (the default user and home directory), we can make Raspbian run them on boot. We do this by adding them to `/etc/rc.local`:

{% highlight bash %}
python /home/pi/purge_old_recordings.py
python /home/pi/record.py &
{% endhighlight %}

Be sure to add these lines _before_ the `exit 0`.

Now, when the Pi gets power, it will boot up Raspbian and automatically start recording video clips from the webcam by running our Python scripts.

{% highlight python %}
{% endhighlight %}

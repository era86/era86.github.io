---
layout: post
title: "Enabling WiFi and SSH on a Raspberry Pi in Ubuntu 16.04"
date: 2018-03-21
comments: true
---

[![Pi Zero W](/assets/images/posts/bare-pi.png){: .bordered.landing-image.centered }](/assets/images/posts/bare-pi.png)

There are several ways to interface with a Raspberry Pi device. The most straight-forward way is probably to plug in a USB keyboard and monitor. However, it can be seen as more convenient to SSH into the device and work with it over WiFi, especially if it's a headless device.

One of the most popular operating systems for the Raspberry Pi is [Raspbian](https://www.raspberrypi.org/downloads/raspbian/). There's a non-desktop version of it called Raspbian Lite. It's simple to [flash Raspbian Lite onto a micro-SD card](https://www.raspberrypi.org/documentation/installation/installing-images/). Once the operating system is flashed, it's even simpler to get Raspbian connected to WiFi and accept SSH clients.

## Mount the `rootfs` and `boot` Partition of SD Card

Ubuntu automatically mounts the `boot` and `rootfs` partitions when the micro-SD card is plugged into the computer.

[![Pi Partitions Ubuntu](/assets/images/posts/pi-partition-ubuntu.png){: .bordered }](/assets/images/posts/pi-partition-ubuntu.png)

If not, they can be mounted manually on the command line.

First, we need to find the device to mount:
{% highlight bash %}
sudo fdisk -l
{% endhighlight %}

In the output, we should see our SD card:
{% highlight bash %}
Disk /dev/sdb: 59.6 GiB, 64021856256 bytes, 125042688 sectors
...

Device     Boot Start       End   Sectors  Size Id Type
/dev/sdb1        8192     93236     85045 41.5M  c W95 FAT32 (LBA)
/dev/sdb2       94208 125042687 124948480 59.6G 83 Linux
{% endhighlight %}

Now, we use the `mount` command to mount the partitions:
{% highlight bash %}
sudo mkdir /media/boot
sudo mount /dev/sdb1 /media/boot

sudo mkdir /media/rootfs
sudo mount /dev/sdb2 /media/rootfs
{% endhighlight %}

## Automatically connect to a WiFi Network

In order to conect to a wireless network on boot, we need to supply Raspbian with the SSID and password. This is done by  adding an entry to `/etc/wpa_supplicant/wpa_supplicant.conf` in the `rootfs` partition:

{% highlight bash %}
network={
    ssid="SSID for Wireless Network"
    psk="PasswordForWiFi"
}
{% endhighlight %}

After saving the file, Raspbian will attempt to connect to the wireless network on boot.

## Enable SSH

Assuming the WiFi connection is set up properly, we can enable SSH connections to Raspbian by adding a new file named `ssh` to the `boot` partition:

{% highlight bash %}
sudo touch /media/boot/ssh
{% endhighlight %}

With the file in the right place, Raspbian wll enable SSH on boot.

## Booting the Raspberry Pi and SSH-ing In

If everything is configured properly, we can boot up the Raspberry Pi and SSH into the device with the default credentials:

{% highlight bash %}
# user: pi
# password: raspberry

ssh pi@192.x.x.1
{% endhighlight %}

The assigned IP address for the Raspberry Pi can be found in the DHCP client list for the router.

[![DHCP List](/assets/images/posts/dhcp-list.png){: .bordered }](/assets/images/posts/dhcp-list.png)

Instructions for accessing the DHCP client list will vary with each router.

## Conclusion

Now, we can work on the Raspberry Pi from another computer, rather than another keyboard and monitor! 

Questions, concerns, or corrections? Let me know in the comments!

---
layout: post
title:  "Fixing Volume Controls on the Asus ZenBook 3 (UX390UA) in Ubuntu 16.04"
date:   2017-10-03
comments: true
---

[![Asus Speaker](/assets/images/posts/asus-speaker.jpg){: .bordered.landing-image.centered }](/assets/images/posts/asus-speaker.jpg)

I recently purchased an [Asus ZenBook 3](https://www.asus.com/us/Laptops/ASUS-ZenBook-3-UX390UA) to replace my aging Thinkpad X220. Most things work right out of the box just fine, but I noticed the audio function controls having no affect on the *actual* volume of the laptop.

[![Volume Controls](/assets/images/posts/volume-controls.png){: .bordered }](/assets/images/posts/volume-controls.png)

After a bit of Googling, I came upon an old [Ubuntu Forums post](https://ubuntuforums.org/showthread.php?t=2340639&page=2) with a solution to my problem. Credit goes to a user named **hanni_ali**.

# Taking Back Controls

First, we find and edit the PulseAudio config file for analog output:

{% highlight bash %}
sudo vim /usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common
{% endhighlight %}

Then, we locate the following configuration entry:

{% highlight bash %}
[Element PCM]
switch = mute
volume = merge
override-map.1 = all
override-map.2 = all-left,all-right
{% endhighlight %}

And replace it with:

{% highlight bash %}
[Element Master]
switch = mute
volume = ignore

[Element PCM]
switch = mute
volume = merge
override-map.1 = all
override-map.2 = all-left,all-right

[Element LFE]
switch = mute
volume = ignore
{% endhighlight %}

Finally, we save the file and reboot the laptop. When things are all started up, the volume controls should work!

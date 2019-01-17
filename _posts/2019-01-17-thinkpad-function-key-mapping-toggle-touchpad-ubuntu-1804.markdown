---
layout: post
title:  "ThinkPad Function-Key Mapping to Toggle Touchpad in Ubuntu 18.04"
date:   2019-01-17
landing-image: "/assets/images/posts/thinkpad-x1-touchpad.png"
comments: true
---

[![ThinkPad X1 Touchpad]({{ page.landing-image }}){: .bordered.landing-image.centered }]({{ page.landing-image }})

As a ThinkPad enthusiast, I'm a fan of using the TrackPoint for mouse navigation. I prefer to disable the touchpad altogether, just to avoid accidental clicks caused by my palms.

I recently installed [Ubuntu 18.04](http://releases.ubuntu.com/18.04/) on my X1 Carbon (5th-Gen) and couldn't find a straightfoward way to toggle the touchpad on and off with a keyboard shortcut. After some Googling, I managed to map one of my unused function-keys to toggle the touchpad.

These are the steps it took to get things working!

### Define an ACPI event to run a script on keypress

Function-key events can be found by opening the terminal and running `acpi_listen`. When a key is pressed, its corresponding event name will be displayed:

{% highlight bash %}
ibm/hotkey LEN0268:00 00000080 00001311
{% endhighlight %}

Using the event name, we can define an ACPI event by creating a new file in `/etc/acpi/events/`:

`/etc/acpi/events/ibm-touchpad`:

{% highlight bash %}
event=ibm/hotkey LEN0268:00 00000080 00001315
action=/etc/acpi/ibm-touchpad.sh
{% endhighlight %}

`event` is the name of our desired function-key event. `action` is the script we will create in the next step.

### Create a custom script to toggle the touchpad

The script will use `xinput` to find the status of the touchpad and toggle it accordingly. For `xinput` to work, we need to specify the `XAUTHORITY` environment-variable in the script. 

We can get this by running `echo $XAUTHORITY`:

{% highlight bash %}
/run/user/1000/gdm/Xauthority
{% endhighlight %}

Now, we can create our new script:

`/etc/acpi/ibm-touchpad.sh`:

{% highlight bash %}
#!/bin/bash

# XAUTHORITY value from 'echo $XAUTHORITY'
export XAUTHORITY="/run/user/1000/gdm/Xauthority"
export DISPLAY=":`ls -1 /tmp/.X11-unix/ | sed -e s/^X//g | head -n 1`"

# 'Synaptics' is the name of the touchpad manufacterer for ThinkPads (as of writing)
read TPdevice <<< $( xinput | sed -nre '/Synaptics/s/.*id=([0-9]*).*/\1/p' )
state=$( xinput list-props "$TPdevice" | grep "Device Enabled" | grep -o "[01]$" )

# Check the state of the device and enable/disable accordingly
if [ "$state" -eq '1' ];then
  xinput --disable "$TPdevice"
else
  xinput --enable "$TPdevice"
fi
{% endhighlight %}

Then, we make the script executable (_Note: You may need to `sudo` this command._):

{% highlight bash %}
chmod +x /etc/acpi/ibm-touchpad.sh
{% endhighlight %}

Finally, restart the system and log back in. If things are set up properly, the function-key should toggle the touchpad!

### Conclusion

The following links were extremely helpful in getting this working:

* [AskUbuntu post with enable/disable touchpad script](https://askubuntu.com/questions/844151/enable-disable-touchpad)
* [UbuntuWiki article on `xinput`](https://wiki.ubuntu.com/X/Config/Input)
* [ThinkWiki article on configuring ACPI](http://www.thinkwiki.org/wiki/How_to_configure_acpid)

Questions? Suggestions? Corrections? Leave me a comment. Cheers!

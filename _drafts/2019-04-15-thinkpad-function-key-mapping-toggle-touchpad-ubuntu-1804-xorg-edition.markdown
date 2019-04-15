---
layout: post
title:  "ThinkPad Function-Key Mapping to Toggle Touchpad in Ubuntu 18.04 (Xorg Edition)"
date:   2019-04-15
landing-image: "/assets/images/posts/thinkpad-x1-touchpad.png"
comments: true
---

[![ThinkPad X1 Touchpad]({{ page.landing-image }}){: .bordered.landing-image.centered }]({{ page.landing-image }})

This is a follow-up to my [existing blog post](/2019/01/17/thinkpad-function-key-mapping-toggle-touchpad-ubuntu-1804.html) on setting a function-key to toggle the touchpad in Ubuntu 18.04 on the ThinkPad X1 Carbon (5th-Gen).

The instructions worked for awhile, but differences between [Wayland and Xorg](https://www.omgubuntu.co.uk/2018/01/xorg-will-default-display-server-ubuntu-18-04-lts) eventually led to it breaking in kernel version `4.15.0-47-generic`. I suspect it has something to do with Xorg's [limit on keycodes above 255](https://www.x.org/releases/X11R7.7/doc/xproto/x11protocol.html#Keyboards).

Here are updated instructions for getting a function-key to toggle the touchpad in Ubuntu 18.04 for Xorg!

### Find the event device for function-keys

First, we need to find out the device that handles the function-keys on the ThinkPad keyboard. On my system, it's called `"ThinkPad Extra Buttons"`.

To get more information about the device, run `cat /proc/bus/input/devices`. A block for `"ThinkPad Extra Buttons"` should appear among the list of devices:

{% highlight bash %}
I: Bus=0019 Vendor=17aa Product=5054 Version=4101
N: Name="ThinkPad Extra Buttons"
...
H: Handlers=rfkill kbd event6
...
{% endhighlight %}

Take note of `event6`. It'll be used in the next section.

### Find the scancode for a function-key

In order to remap our function-key, we'll need its [**scancode**](https://en.wikipedia.org/wiki/Scancode). This is a signal the keyboard sends to the computer indicating it has been pressed.

To get the scancode, we use a utility named `evtest` on our event device from the previous step, `event6`. Run `sudo evtest /dev/input/event6`:

{% highlight bash %}
Input driver version is 1.0.1
Input device ID: bus 0x19 vendor 0x17aa product 0x5054 version 0x4101
Input device name: "ThinkPad Extra Buttons"
...
Testing ... (interrupt to exit)
{% endhighlight %}

While `evtest` is running, press the function-key. In my case, I wanted to remap the "keyboard" function-key (`Fn`+`F11`):

{% highlight bash %}
Event: time 1555302565.097470, type 4 (EV_MSC), code 4 (MSC_SCAN), value 49
Event: time 1555302565.097470, type 1 (EV_KEY), code 374 (KEY_KEYBOARD), value 1
Event: time 1555302565.097470, -------------- SYN_REPORT ------------
Event: time 1555302565.097517, type 4 (EV_MSC), code 4 (MSC_SCAN), value 49
Event: time 1555302565.097517, type 1 (EV_KEY), code 374 (KEY_KEYBOARD), value 0
Event: time 1555302565.097517, -------------- SYN_REPORT ------------
{% endhighlight %}

Take note of the `value 49`. This is the scancode!

### Create a custom `hwdb` keyboard mapping

_Note: It might be worth some time to read up about [`hwdb`](https://www.freedesktop.org/software/systemd/man/hwdb.html)._

Armed with the scancode, we create a custom `hwdb` configuration to map it to our desired keycode. Create a new file in `/lib/udev/hwdb.d/` (I named it `90-custom-keyboard.hwdb`, but it can be anything):

{% highlight bash %}
evdev:name:ThinkPad Extra Buttons:dmi:bvn*:bvr*:bd*:svnLENOVO*:pn*
 KEYBOARD_KEY_49=f21 # tell keycode 49 to toggle touchpad (f21)
{% endhighlight %}

The first line is a match-string for our device, `"Thinkpad Extra Buttons"`. The left-hand side of second line is the scancode for our key appended to `"KEYBOARD_KEY_"`. The event, `f21`, is the "toggle touchpad" keycode.

_Note: I found my device match-string and "toggle touchpad" keycode in `/lib/udev/hwdb.d/60-keyboard.hwdb`._

After saving the new file, run `sudo udevadm hwdb --update`.

Finally, restart the system and log back in. If things are set up properly, the function-key should toggle the touchpad!

### Conclusion

The following links were extremely helpful in getting this working:

* [Slow & Steady Blog: Linux keymapping with udev hwdb](https://yulistic.gitlab.io/2017/12/linux-keymapping-with-udev-hwdb/)
* [ThinkPad Scripts: Configuring Additional Hardware Keys](https://thinkpad-scripts.readthedocs.io/en/latest/guides/additional-keys.html)
* [MOHAN43U's Blog: Howto remap keyboard keys in Linux](https://mohan43u.wordpress.com/2017/05/29/howto-remap-keyboard-keys-in-linux/)

Questions? Suggestions? Corrections? Leave me a comment. Cheers!

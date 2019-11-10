---
layout: post
title:  "A Fix for Slow TrackPoint Speed in Ubuntu 18.04 (Unity) on ThinkPad"
date:   2019-11-10
landing-image: "/assets/images/posts/thinkpad-x1-slow-tackpoint.png"
comments: true
---

[![ThinkPad X1 TrackPoint]({{ page.landing-image }}){: .bordered.landing-image.centered }]({{ page.landing-image }})

I recently ran a system update for Ubuntu on my ThinkPad X1 Carbon (5th-Gen). Afterwards, I noticed the speed of the TrackPoint was _really_ slow. The pointer would barely move! A quick search on the web led to many potential fixes, but none of them worked on my particular setup ([Ubuntu 18.04](http://releases.ubuntu.com/18.04/) with Unity).

After trying several solutions, I finally found a working one using `xinput` commands in `~/.bashrc`.

### Get TrackPoint Device Name

First, get the name of the device for the TrackPoint using `xinput`:

{% highlight bash %}
xinput | grep Track
{% endhighlight %}

The output should look something like:

{% highlight bash %}
⎜ ↳ TPPS/2 Elan TrackPoint  id=12   [slave  pointer  (2)]
{% endhighlight %}

In my case, the name of the TrackPoint device is `"TPPS/2 Elan TrackPoint"`.

### Set the TrackPoint Speed

Using the name of the device, add the following lines to `~/.bashrc`:

{% highlight bash %}
xinput --set-prop "TPPS/2 Elan TrackPoint" "libinput Accel Profile Enabled" 1, 0
xinput --set-prop "TPPS/2 Elan TrackPoint" "libinput Accel Speed" 0.8
{% endhighlight %}

The second line is what sets the speed. It can be set to any value between `0.0` and `1.0`. The higher the number, the faster the TrackPoint speed.

### (Optional) Prevent `tmux` from Resetting the Speed

In [`tmux`](https://thoughtbot.com/blog/a-tmux-crash-course), I noticed every time a new pane was opened, the TrackPoint speed would slow back down. This is because `tmux` spins up a different login shell, using `.bash_profile` to load the settings. So, the commands in `.bashrc` are never picked up.

To fix this, just create `~/.bash_profile` and add:

{% highlight bash %}
source ~/.bashrc
{% endhighlight %}

Now, with every new `tmux` pane, the TrackPoint speed is preserved!

Questions? Comments? Corrections? Leave me a comment. Cheers!

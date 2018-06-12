---
layout: post
title:  "Natural TrackPoint Scrolling on ThinkPad in Ubuntu 16.04"
date:   2018-06-11
landing-image: "/assets/images/posts/trackpoint-scrolling.png"
comments: true
---

[![TrackPoint Scrolling]({{ page.landing-image }}){: .bordered.landing-image.centered }]({{ page.landing-image }})

In Ubuntu, it's quite easy to set "natural" scrolling on the touchpad. We can do this by checking a box in `Mouse & Touchpad` settings. However, for ThinkPad users, this doesn't change the scrolling settings on the TrackPoint. To get the TrackPoint settings to match the natural scrolling on the touchpad, we make use of [`xinput`](https://linux.die.net/man/1/xinput).

### Find the right settings

First, we find the property we need to modify. We do this by doing:

{% highlight bash %}
xinput list-props "TPPS/2 IBM TrackPoint"
{% endhighlight %}

In the output, there should be an entry for wheel-emulation:

{% highlight bash %}
  ...
  Evdev Wheel Emulation Axes (422):       6, 7, 4, 5
  ...
{% endhighlight %}

### Set the proper values

To get natural scrolling on the TrackPoint, we make a small change to the integer values:

{% highlight bash %}
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 7, 6, 5, 4
{% endhighlight %}

Now, the TrackPoint should have natural scrolling!

### Make the change permanent

When we log out, our wheel-emulation settings get reverted back to default. If we want natural scrolling to be set upon log-in, we append our command to `~/.profile`:

{% highlight bash %}
echo 'xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 7, 6, 5, 4' >>~/.profile
{% endhighlight %}

Now, our changes are permanent!

For more ways to configure the TrackPoint, visit [this ThinkWiki page](http://www.thinkwiki.org/wiki/How_to_configure_the_TrackPoint).

Questions? Comments? Corrections? Leave me a comment. Cheers!

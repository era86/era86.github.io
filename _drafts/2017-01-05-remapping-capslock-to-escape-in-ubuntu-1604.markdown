---
layout: post
title:  "Remapping CapsLock to Escape in Ubuntu 16.04"
date:   2017-01-05
comments: true
---

[![](/assets/images/posts/capslock.jpg){: .bordered.landing-image.centered }](/assets/images/posts/capslock.jpg)

As a Vim user, I prefer to remap the `CapsLock` key on my keyboard to `Escape`. It makes it easier to switch between `insert` and `visual` mode without having to stretch my pinky all the way up to the top-left corner of the keyboard. It's a minor detail, but a hard one to live without!

There are several ways to achieve this, but these are the simplest steps I could find.

# Install DConf Tools 

[DConf](https://wiki.gnome.org/action/show/Projects/dconf?action=show&redirect=dconf) is a key-value database for storing desktop environment settings in Ubuntu, including our keyboard mappings. To edit thse settings, we need a utility called `dconf-tools`.

We can install it using the command:

{% highlight bash %}
sudo apt-get install dconf-tools
{% endhighlight %}

Now, we can modify the DConf settings for our keyboard!

# Remapping via Command Line

Using the `dconf` command, we can easily set the `xkb-options` value in our key-value store:

{% highlight bash %}
dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:escape']"
{% endhighlight %}

You can use `dconf` to set other options as well. A list of options can be found by doing:

{% highlight bash %}
man xkeyboard-config
{% endhighlight %}

# Remapping via GUI Dconf Editor

Open up the DConf Editor by searching for it in the Unity dashboard:

[![](/assets/images/posts/dconf-01.png){: .bordered }](/assets/images/posts/dconf-01.png)

Using the tree on the left, navigate to: → `org` → `gnome` → `desktop` → `input-sources`

[![](/assets/images/posts/dconf-02.png){: .bordered }](/assets/images/posts/dconf-02.png)

In the `Value` column, we can add our configuration: `['caps:escape']`.

[![](/assets/images/posts/dconf-03.png){: .bordered }](/assets/images/posts/dconf-03.png)

Thats it! Now, the `CapsLock` key will be remapped to function as the `Escape` key whenever we log into Ubuntu!

Questions? Corrections? Let me know in the comments!

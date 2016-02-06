---
layout: post
title: "Automatic 'ls' after 'cd' in the Terminal"
date: 2012-05-01
comments: true
---

As a web developer, I find myself navigating around in the terminal most of my time. The most frequent combination of commands I usually run are `cd` immediately followed by an `ls`. After a bit of Googling, I found a way to do this automatically in Ubuntu at home and OSX at work by adding a couple of lines to my **.bashrc** (**.bash\_profile** for OSX).  

{% highlight bash %}
function cs()
{
  if [ $# -eq 0 ]; then
    cd && ls
  else
    cd "$*" && ls
  fi
}
alias cd='cs'
{% endhighlight %}

Easy. All it does is create a function `cs()` that will call the standard `cd` command with any arguments passed into it. Once the directory is changed, it will list the directory contents with an `ls`. The default behavior of `cd` is replaced using `alias`.

**Update 05-01-2012:** I noticed that this disables the default behavior of `cd` going to the home directory when no arguments are passed.  There is probably a much more clever way to handle this, but the above code now handles that.

## Resources:
[Ubuntu Forums Post](http://ubuntuforums.org/showthread.php?t=1708802)

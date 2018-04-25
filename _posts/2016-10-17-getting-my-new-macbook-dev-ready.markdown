---
layout: post
title:  "Getting My New Macbook Dev-Ready"
date:   2016-10-17
landing-image: "/assets/images/posts/macbook.jpg"
comments: true
---

[![Macbook](/assets/images/posts/macbook.jpg){: .bordered.landing-image.centered }](/assets/images/posts/macbook.jpg)

For [my trip to Europe](http://urban-trailseeker.blogspot.com/2016/07/backpacks-and-train-tracks-our-month-in.html), I purchased a brand new [Macbook](http://www.apple.com/macbook/)! It's the perfect travel companion: lightweight, decent battery life, and just powerful enough to do basic computing (email, blogging, etc).

I bought it to replace my trusty Thinkpad x220, which I've used as a development machine for about *five* years now. With Ubuntu as my operating system, most everything I needed as a web developer was already installed and set up. Since this Macbook is a brand new laptop, I thought I'd share my process for getting it "dev-ready".

## Install Git via Xcode Command Line Tools

My version control system of choice is [Git](https://git-scm.com/), which is very popular amongst all developers. The easiest way to get Git on my Macbook is through [Xcode Command Line Tools](https://developer.apple.com/library/ios/technotes/tn2339/_index.html). For the latest version of Git, it can easily be [installed manually](https://git-scm.com/download/mac).

Xcode Command Line Tools can be installed by typing the following into the terminal:

{% highlight bash %}
xcode-select --install
{% endhighlight %}

[![Xcode Install 1](/assets/images/posts/xcode-install-1.png){: .bordered }](/assets/images/posts/xcode-install-1.png)

[![Xcode Install 3](/assets/images/posts/xcode-install-3.png){: .bordered }](/assets/images/posts/xcode-install-3.png)

[![Xcode Install 4](/assets/images/posts/xcode-install-4.png){: .bordered }](/assets/images/posts/xcode-install-4.png)

Once installation completes, running `git --version` should yield something like:

{% highlight bash %}
git version 2.7.4 (Apple Git-66)
{% endhighlight %}

## Clone my Vim Configuration (vimrc)

[Vim](http://www.vim.org/) is my text editor of choice. There are many resources out on the web about creating `vimrc` configuration files, so I won't go into too much detail about my own. Though, I have it [hosted on Github](https://github.com/era86/dotfiles/blob/master/vimrc) for anyone who wants to check it out. 

Here are some articles I found useful when setting up my own `vimrc`:

* [The ultimate Vim configuration - vimrc](https://amix.dk/vim/vimrc.html) 
* [A Good Vimrc](http://dougblack.io/words/a-good-vimrc.html) 
* [Vim Splits - Move Faster and More Naturally](https://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally) 
* [Vim Splits: A Guide to Doing Exactly What You Want](https://technotales.wordpress.com/2010/04/29/vim-splits-a-guide-to-doing-exactly-what-you-want)

## Install Vundle

To enhance my programming experience within Vim, I install a [select list of Vim plugins](). [Vundle](https://github.com/VundleVim/Vundle.vim) makes managing those plugins very easy!

To install Vundle, clone the Git repository into `~/.vim` by running:

{% highlight bash %}
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
{% endhighlight %}

Then, the following snippet is added to the top of `vimrc`:

{% highlight viml %}
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" List of Vim plugins go here
" Visit http://vimawesome.com/ for a list of plugins!
Plugin 'path/to/plugin/repository'

call vundle#end()

filetype plugin indent on
{% endhighlight %}

Now, fire up `vim` and run `:PluginInstall`.

Once the command is finished, all of the Vim plugins listed in `vimrc` should be installed and ready to use!

## Install Homebrew

Installing tools and applications in Ubuntu is really easy with [apt](https://help.ubuntu.com/lts/serverguide/apt.html), its package management system. The equivalent for OS X is [Homebrew](http://brew.sh/), also known as "the missing package manager for OS X."

Homebrew can easily be installed by typing the following into the terminal:

{% highlight bash %}
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
{% endhighlight %}

[![Homebrew Install 1](/assets/images/posts/homebrew-install-1.png){: .bordered }](/assets/images/posts/homebrew-install-1.png)

Hitting `Enter` will let start the installation, which fetches and builds Homebrew.

[![Homebrew Install 2](/assets/images/posts/homebrew-install-2.png){: .bordered }](/assets/images/posts/homebrew-install-2.png)

Once installation is complete, running `brew -v` should yield something like:

{% highlight bash %}
Homebrew 0.9.9 (git revision cc10; last commit 2016-06-14)
Homebrew/homebrew-core (git revision d8f2; last commit 2016-06-14)
{% endhighlight %}

## Install Ack

[Ack](http://beyondgrep.com/) is very similar to [Grep](http://www.gnu.org/software/grep/manual/grep.html), which allows users to text-search across multiple files. I use it within Vim via the [AckVim plugin](http://vimawesome.com/plugin/ack-vim). With Homebrew, it's very easy to install:

{% highlight bash %}
brew install ack
{% endhighlight %}

[![Ack Install](/assets/images/posts/ack-install.png){: .bordered }](/assets/images/posts/ack-install.png)

Once installation is complete, running `ack --version` should yield something like:

{% highlight bash %}
ack 2.14
Running under Perl 5.18.2 at /usr/bin/perl

Copyright 2005-2014 Andy Lester.

This program is free software.  You may modify or distribute it
under the terms of the Artistic License v2.0.
{% endhighlight %}

## Install Tmux

[Tmux](https://tmux.github.io/) is a tool that allows users to manage multiple terminal panes and sessions from within a single window. It makes life within the terminal *much* easier! Again, with Homebrew, it's very easy to install:

{% highlight bash %}
brew install tmux
{% endhighlight %}

[![Tmux Install 1](/assets/images/posts/tmux-install-1.png){: .bordered }](/assets/images/posts/tmux-install-1.png)

[![Tmux Install 2](/assets/images/posts/tmux-install-2.png){: .bordered }](/assets/images/posts/tmux-install-2.png)

Once installation is complete, running `tmux -V` should yield something like:

{% highlight bash %}
tmux 2.2
{% endhighlight %}

## Clone my Tmux Configuration (tmux.conf)

Like my `vimrc`, my `tmux.conf` is [hosted on Github](https://github.com/era86/dotfiles/blob/master/tmux.conf).

Here are some articles I found useful when setting up my own `tmux.conf`:

* [Making tmux Pretty and Usable](http://www.hamvocke.com/blog/a-guide-to-customizing-your-tmux-conf/)
* [Seamlessly Navigate Vim and tmux Splits](https://robots.thoughtbot.com/seamlessly-navigate-vim-and-tmux-splits) 
* [tmux Copy & Paste on OS X: A Better Future](https://robots.thoughtbot.com/tmux-copy-paste-on-os-x-a-better-future)

---
layout: post
title:  "Vagrant/VirtualBox with Secure Boot in Ubuntu 16.04"
date:   2018-02-05
comments: true
---

On my current laptop, I dual-boot Windows 10 and Ubuntu 16.04 side-by-side. In order to be able to boot into Windows, I need to keep Secure Boot enabled.

I use virtual machines to manage individual development environments using Vagrant and VirtualBox. After installing both and running `vagrant up`, I was getting the following error:'


{% highlight bash %}
The provider 'virtualbox' that was requested to back the machine
'default' is reporting that it isn't usable on this system. The
reason is shown below:

VirtualBox is complaining that the installation is incomplete. Please
run `VBoxManage --version` to see the error message which should contain
instructions on how to fix this error.
{% endhighlight %}

When Ubuntu installs the VirtualBox package via `sudo apt-get install virtualbox`, it has to install `vbox*` kernel modules. However, unsigned modules are not allowed to run while Secure Boot is enabled. Since we cannot disable Secure Boot, the solution is to sign the VirtualBox kernel modules.




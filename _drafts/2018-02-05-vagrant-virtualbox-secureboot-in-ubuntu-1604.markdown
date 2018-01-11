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

## Create a new Machine Owner Key (MOK)

We'll start by creating an RSA key-pair to sign the kernel modules with. This done using the `openssl` tool:

{% highlight bash %}
openssl req -new -x509 -newkey rsa:2048 -keyout mok.priv -outform DER -out mok.der -nodes -days 36500 -subj "/CN=[unique value]/"
{% endhighlight %}

{% highlight bash %}
# output from openssl
{% endhighlight %}

## Sign the VirtualBox modules for our kernel

Next, we'll actually sign all of the VirtualBox modules with our current kernel using a script called `sign-file` included in the build headers. We leverage `uname -r` to get our kernel version and `modinfo` to get the relevant modules:

{% highlight bash %}
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./mok.priv ./mok.der $(modinfo -n vboxdrv)
{% endhighlight %}

{% highlight bash %}
# output from sign-file
{% endhighlight %}

## Register the new keys with Secure Boot

We'll need to import our public key (`mok.der`) so that the UEFI firmware can trust the newly-signed modules. To do this, we make use of `mokutil`:

{% highlight bash %}
sudo mokutil --import mok.der
{% endhighlight %}

{% highlight bash %}
# output and password prompts for mokutil
{% endhighlight %}

We can use a really simple password here, it's only used once.

At this point, we have a key (our new MOK) shared between the UEFI firmware and the client kernel. We also have the VirtualBox kernel modules signed with this key.

## Reboot and Enroll the new Machine Owner Key

Reboot the machine. Upon reboot, a MOK management utility will automatically start. This will look a bit different on each firmware vendor, but mostly the same.

Choose "Enroll MOK":

[![MOK Utility 1](/assets/images/posts/mok-util-1.png){: .bordered }](/assets/images/posts/mok-util-1.png)

You should be able to see the name of the new key we imported before. Continue and Confirm Enrollment:

[![MOK Utility 2](/assets/images/posts/mok-util-2.png){: .bordered }](/assets/images/posts/mok-util-2.png)

[![MOK Utility 3](/assets/images/posts/mok-util-3.png){: .bordered }](/assets/images/posts/mok-util-3.png)

Enter the password used when registering the new keys with `mokutil`:

[![MOK Utility 4](/assets/images/posts/mok-util-4.png){: .bordered }](/assets/images/posts/mok-util-4.png)

Complete the final step and reboot the machine.

## Log in and load the VirtualBox modules

With everything signed and registered, we can now (re)load the VirtualBox kernel modules:

{% highlight bash %}
sudo modprobe vboxdrv 
{% endhighlight %}

## Conclusion

Now that VirtualBox is properly installed and functioning with our kernel, running `vagrant up` should work normally.

I found the following articles extremely helpful in getting this to work:

* [VirtualBox + Secure Boot + Ubuntu = fail](https://stegard.net/2016/10/virtualbox-secure-boot-ubuntu-fail)
* [Systemtap UEFI Secure Boot Support](https://sourceware.org/systemtap/wiki/SecureBoot)

Questions, suggestions, or corrections? Please let me know in the comments!

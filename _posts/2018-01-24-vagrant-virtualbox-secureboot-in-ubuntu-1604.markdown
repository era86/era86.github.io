---
layout: post
title:  "Vagrant and VirtualBox with Secure Boot in Ubuntu 16.04"
date:   2018-01-24
comments: true
---

[![Secure Computer](/assets/images/posts/secure-computer.png){: .landing-image.centered }](/assets/images/posts/secure-computer.png)

To dual-boot Windows 10 and Ubuntu 16.04 side-by-side, [Secure Boot](https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-secure-boot) must remain enabled. Unfortunately, this clashes with [Vagrant](https://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/) in Ubuntu.

A symptom of the issue is the following error when attempting `vagrant up`:

{% highlight console %}
The provider 'virtualbox' that was requested to back the machine
'default' is reporting that it isn't usable on this system. The
reason is shown below:

VirtualBox is complaining that the installation is incomplete. Please
run `VBoxManage --version` to see the error message which should contain
instructions on how to fix this error.
{% endhighlight %}

VirtualBox requires new kernel modules to run in Ubuntu, installed via `sudo apt-get install virtualbox-dkms`. However, unsigned modules are not allowed to run with Secure Boot enabled. Since disabling Secure Boot isn't an option for dual-booters, the solution is to sign the VirtualBox kernel modules manually.

## Create a new Machine Owner Key (MOK)

We'll start by switching to `root`:

{% highlight bash %}
sudo su - root
{% endhighlight %}

Then, we create a Machine Owner Key (MOK) pair using the `openssl` tool:

{% highlight bash %}
openssl req -new -x509 -newkey rsa:2048 -keyout mok.priv -outform DER -out mok.der -nodes -days 36500 -subj "/CN=[name of key]/"
{% endhighlight %}

Two new files will appear in the current directory: `mok.priv` and `mok.der`

## Sign the VirtualBox modules for our kernel

Next, we'll sign the VirtualBox modules for our Linux kernel using a utility script named `sign-file`. We leverage `uname -r` to get our kernel version and `modinfo` to get the relevant module information:

{% highlight bash %}
/usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./mok.priv ./mok.der $(modinfo -n vboxdrv)
{% endhighlight %}

## Register the new keys with Secure Boot

We'll need to import our public key (`mok.der`) so to make our UEFI firmware trust the newly-signed modules. To do this, we make use of `mokutil`:

{% highlight bash %}
mokutil --import mok.der
{% endhighlight %}

Enter a really simple password here, it's only used once.

At this point, we have a key-pair shared between the UEFI firmware and the client kernel. We also have the VirtualBox kernel modules signed with this key.

## Reboot and Enroll the new Machine Owner Key

Reboot the machine. Upon reboot, a MOK management utility will automatically start. This will look a bit different on each firmware vendor, but mostly the same. It should look something like this:

[![MOK Management](/assets/images/posts/mok-management.png){: .bordered }](/assets/images/posts/mok-management.png)

The interface is pretty straightforward, follow the steps:

* Choose "Enroll MOK"
* Continue and confirm enrollment
* Enter the password used when registering the new keys with `mokutil`

At last, reboot the machine.

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

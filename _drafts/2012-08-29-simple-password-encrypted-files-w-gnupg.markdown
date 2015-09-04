---
layout: post
title: "Simple Password Encrypted Files w/ GnuPG"
date: 2012-08-29
comments: true
---

[![GNUPG](/assets/images/posts/gnupg.png){: .bordered.landing-image.centered }](/assets/images/posts/gnupg.png)

If you are sending files or documents with sensitive information (eg.  database credentials), you probably don't want to send it without making sure it is encrypted. In Linux and OSX, I use a tool called [GnuPG](http://www.gnupg.org/) to add password protection to files I want to share with other people. This is, by no means, the best way to send sensitive information to someone else, but it does provide a small layer of protection against an unintended recipient opening and reading the contents.

## Install GnuPG

For Ubuntu, fire up a terminal and run:

{% highlight bash %}
sudo apt-get install gpg
{% endhighlight %}

For OSX, install [Homebrew](http://mxcl.github.com/homebrew/) and run:

{% highlight bash %}
brew install gpg
{% endhighlight %}

## Encrypting Files

To encrypt a sensitive file, navigate to the directory of the file and run:

{% highlight bash %}
gpg -c sensitive.txt
{% endhighlight %}

Output:

{% highlight bash %}
Enter passphrase: 
Repeat passphrase: 
{% endhighlight %}

If all is well, GnuPG will create an encrypted file named **sensitive.txt.gpg**. If someone tries to open and read the contents, they will get nothing but gibberish!

## Decrypting Files

To decrypt a file, navigate to the directory of the file and run:

{% highlight bash %}
gpg sensitive.txt.gpg
{% endhighlight %}

Output:

{% highlight bash %}
gpg: CAST5 encrypted data
Enter passphrase: 
{% endhighlight %}

Now, enter the passphrase set for the file during encryption. Voila! The file is now decrypted as **sensitive.txt**.

*Note: You may get the following:* `gpg: WARNING: message was not integrity protected`*However it doesn't affect the result.*

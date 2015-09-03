---
layout: post
title: Simple Password Encrypted Files w/ GnuPG
date: '2012-08-29T16:23:00.000-07:00'
author: Frederick Ancheta
tags:
- sensitive
- gpg
- encrypt
- password
- linux
- gnupg
- email
- decrypt
- osx
- message
modified_time: '2012-08-30T12:44:53.331-07:00'
thumbnail: http://2.bp.blogspot.com/-te-r532QOSU/UD6j_7qu6AI/AAAAAAAAAQk/XxYjcGdkc4Q/s72-c/gnupg.png
blogger_id: tag:blogger.com,1999:blog-9008563869490582540.post-4299491742046258592
blogger_orig_url: http://www.runtime-era.com/2012/08/simple-password-encrypted-files-w-gnupg.html
---

[![](http://2.bp.blogspot.com/-te-r532QOSU/UD6j_7qu6AI/AAAAAAAAAQk/XxYjcGdkc4Q/s320/gnupg.png)](http://2.bp.blogspot.com/-te-r532QOSU/UD6j_7qu6AI/AAAAAAAAAQk/XxYjcGdkc4Q/s1600/gnupg.png)

If you are sending files or documents with sensitive information (eg.
database credentials), you probably don't want to send it without making
sure it is encrypted. In Linux and OSX, I use a tool called
[GnuPG](http://www.gnupg.org/) to add password protection to files I
want to share with other people. This is, by no means, the best way to
send sensitive information to someone else, but it does provide a small
layer of protection against an unintended recipient opening and reading
the contents. \
\

### Install GnuPG

For Ubuntu, fire up a terminal and run:

~~~~ {.brush: .bash}
sudo apt-get install gpg
~~~~

For OSX, install [Homebrew](http://mxcl.github.com/homebrew/) and run:

~~~~ {.brush: .bash}
brew install gpg
~~~~

### Encrypting Files

To encrypt a sensitive file, navigate to the directory of the file and
run:

~~~~ {.brush: .bash}
gpg -c sensitive.txt
~~~~

Output:

~~~~ {.brush: .bash}
Enter passphrase: Repeat passphrase: 
~~~~

If all is well, GnuPG will create an encrypted file named
**sensitive.txt.gpg**. If someone tries to open and read the contents,
they will get nothing but gibberish! \
\

### Decrypting Files

To decrypt a file, navigate to the directory of the file and run:

~~~~ {.brush: .bash}
gpg sensitive.txt.gpg
~~~~

Output:

~~~~ {.brush: .bash}
gpg: CAST5 encrypted dataEnter passphrase: 
~~~~

Now, enter the passphrase set for the file during encryption. Voila! The
file is now decrypted as **sensitive.txt**. \
\
*Note: You may get the following: **gpg: WARNING: message was not
integrity protected**, but it doesn't affect the result.*

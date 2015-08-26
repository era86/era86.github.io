---
layout: post
title:  "My \"Bare Minimum\" Vim Plugins"
date:   2015-07-17
comments: true
categories: vim programming
---

Vim has been my programming editor of choice since about 2012. It's an effective text editor at minimum, but it can be configured into a full-fledged IDE if desired. After learning the ins and outs of Vim, it can be difficult to go back to other basic text editors. 

After re-installing Ubuntu on my laptop, I decided to build my Vim configuration up from scratch. This gave me an opportunity to figure out which plugins I absolutely needed to make Vim "usable". Now, this is *very* subjective, but I thought I'd share anyway.

## Vundle

One or two plugins can probably be installed and managed manually. However, it's always a good idea to use some kind of manager/repository to install, remove, or update Vim plugins. Vundle is **a Vim plugin manager**, similar to [Bundle](http://bundler.io/) for Ruby gems or [apt](https://wiki.debian.org/Apt) for Debian Linux packages. Using Vundle, we can easily find and install any plugins we want from within Vim! We can also keep track of any currently installed plugins because they are listed directly in the .vimrc file.

[![Vundle](/assets/images/posts/vundle.gif){: .bordered }](/assets/images/posts/vundle.gif)

[Vundle on Github](https://github.com/gmarik/Vundle.vim)

## CtrlP

Projects come in many shapes and sizes. Often, projects contain up to a hundred individual files nested in several directories! For smaller projects, it's easy enough to use the built-in file manager to navigate around. However, CtrlP is a Vim plugin that gives us the powerful **ability to "fuzzy-search" directories and filenames** throughout a project. Rather than manually traversing the directory tree, we can type any strings or regular expressions *resembling* the full path of the file we want to open. Fuzzy-searching an entire project for files saves so much time, it's hard to live without!

[![CtrlP](/assets/images/posts/ctrlp.gif){: .bordered }](/assets/images/posts/ctrlp.gif)

[CtrlP on VimAwesome](http://vimawesome.com/plugin/ctrlp-vim-state-of-grace)

## AckVim

Many full-fledged IDEs provide a feature for text-searching through multiple files. This is handy for finding object references or function calls throughout an entire project. Text-searching multiple files on the command-line is usually accomplished using [grep](http://unixhelp.ed.ac.uk/CGI/man-cgi?grep). Ack is a different tool that is similar to grep, but was written in Perl 5 with programmers in mind. It's very performant, configurable, and portable. Fortunately, there is a Vim plugin for Ack! With the plugin, **full project text-search and regular expression matching** can be done all from *within* Vim. Any results from a search will be listed conveniently in a new split.

[![Ack](/assets/images/posts/ack.gif){: .bordered }](/assets/images/posts/ack.gif)

[AckVim on VimAwesome](http://vimawesome.com/plugin/ack-vim)

## Fugitive

Most software developers use [Git](http://git-scm.com/) for revision control. It'd be hard to find a developer who hasn't used it! For a long time, I was satisfied running Git commands in a separate terminal window. However, I found myself continuously switching back and forth between Vim and Git windows to edit, stage, and commit. The Fugitive plugin is Vim wrapper for Git. It **allows common Git-related tasks to be run directly from within Vim**! In addition to all basic Git functionality, Fugitive provides its own convenient commands such as [`:Gcommit`](https://github.com/tpope/vim-fugitive/blob/762bfa79795146ee44d50d4ce8b3e36efcb603b8/doc/fugitive.txt##L62-72) and [`:Gblame`](https://github.com/tpope/vim-fugitive/blob/762bfa79795146ee44d50d4ce8b3e36efcb603b8/doc/fugitive.txt##L155-160), which open relevant information and prompts in new splits. Fugitive provides a streamlined Git workflow within Vim.

[![Fugitive](/assets/images/posts/fugitive.gif){: .bordered }](/assets/images/posts/fugitive.gif)

[Fugitive on VimAwesome](http://vimawesome.com/plugin/fugitive-vim)

## NERD Tree

The default file explorer in Vim is fairly sufficient for very simple navigation, but lacks the visual appeal of a true file "explorer". An essential feature of most IDEs is the ability to view and navigate a project hierarchy in a way that makes the most sense: a tree! The NERDTree plugin **provides a usable tree view of a the files and directories of a project** from within a Vim split. The plugin also allows users to do basic file management such as adding, copying, moving, and deleting files and directories! With NERDTree, there is almost no reason to do any file management in a separate terminal window!

[![NERDTree](/assets/images/posts/nerd.gif){: .bordered }](/assets/images/posts/nerd.gif)

[The NERDTree on VimAwesome](http://vimawesome.com/plugin/the-nerd-tree)

## Conclusion

There you have it, a list of plugins making up my "bare-minimum" Vim configuration! Of course, the plugins I have installed will vary depending on the project I'm working on. However, I always start with the foundation of plugins I've outlined above.

Happy Vimming!

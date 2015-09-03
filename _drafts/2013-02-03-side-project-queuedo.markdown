---
layout: post
title: 'Side Project: QueueDo'
date: '2013-02-03T14:27:00.000-08:00'
author: Frederick Ancheta
tags:
- ruby
- todo
- jquery
- sinatra
- task
- side project
modified_time: '2013-02-03T14:27:14.106-08:00'
thumbnail: http://2.bp.blogspot.com/-b3-k4vZMKpU/UQ7jvJNJIqI/AAAAAAAAAnY/FPuNQg1IQxs/s72-c/big-logo.png
blogger_id: tag:blogger.com,1999:blog-9008563869490582540.post-3499329348553730101
blogger_orig_url: http://www.runtime-era.com/2013/02/side-project-queuedo.html
---

\
\

[![](http://2.bp.blogspot.com/-b3-k4vZMKpU/UQ7jvJNJIqI/AAAAAAAAAnY/FPuNQg1IQxs/s320/big-logo.png)\
http://queuedo.herokuapp.com/](http://queuedo.herokuapp.com)

\
\
 When I work on my own projects, I like to keep track of the tasks
involved in getting them done. I started by creating to-do lists in
spreadsheets because it was quick, easy, and simple. Nowadays, I enjoy
using [Trello](https://trello.com/). After signing up and customizing
the boards, I can visualize any project with a virtual Scrum board. \
\
 I created **QueueDo** because I want a simple task tracker that
somewhat resembles a Scrum board. Also, I was bored and wanted to
refresh my memory working with jQuery. With QueueDo, I can:

-   create a to-do list of tasks
-   track which tasks are in progress or complete
-   show which tasks are approaching deadlines

The web application framework of choice is
[Sinatra](http://www.sinatrarb.com/), since all I need to do is serve up
some HTML and JavaScript. The "database" is the browser ([HTML5
LocalStorage](http://diveintohtml5.info/storage.html)). The interface is
[jQuery UI](http://jqueryui.com/). \
\
 You can find the code on [Github](https://github.com/era86/queue_do).
Have fun!

---
layout: post
title: "Side Project: QueueDo"
date: 2013-02-03
landing-image: "/assets/images/posts/queue-do.png"
comments: true
---

[![Queue Do]({{ page.landing-image }}){: .bordered.landing-image.centered }]({{ page.landing-image }})

When I work on my own projects, I like to keep track of the tasks involved in getting them done. I started by creating to-do lists in spreadsheets because it was quick, easy, and simple. Nowadays, I enjoy using [Trello](https://trello.com/). After signing up and customizing the boards, I can visualize any project with a virtual Scrum board.

I created **QueueDo** because I want a simple task tracker that somewhat resembles a Scrum board. Also, I was bored and wanted to refresh my memory working with jQuery. With QueueDo, I can:

* create a to-do list of tasks
* track which tasks are in progress or complete
* show which tasks are approaching deadlines

The web application framework of choice is [Sinatra](http://www.sinatrarb.com/), since all I need to do is serve up some HTML and JavaScript. The "database" is the browser ([HTML5 LocalStorage](http://diveintohtml5.info/storage.html)). The interface is [jQuery UI](http://jqueryui.com/).

You can find the code on [Github](https://github.com/era86/queue_do). Have fun!

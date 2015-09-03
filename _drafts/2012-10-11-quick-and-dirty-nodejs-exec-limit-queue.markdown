---
layout: post
title: Quick and Dirty Node.js Process (Job) Queue
date: '2012-10-11T01:53:00.000-07:00'
author: Frederick Ancheta
tags:
- javascript
- limit
- queue
- nodejs
- exec
modified_time: '2012-10-11T02:01:49.506-07:00'
thumbnail: http://4.bp.blogspot.com/-9EvATBIuyRw/UHaH6oylv6I/AAAAAAAAAR8/Uj0kJk7fTDM/s72-c/MP900411832.JPG
blogger_id: tag:blogger.com,1999:blog-9008563869490582540.post-7764139530280426836
blogger_orig_url: http://www.runtime-era.com/2012/10/quick-and-dirty-nodejs-exec-limit-queue.html
---

[![](http://4.bp.blogspot.com/-9EvATBIuyRw/UHaH6oylv6I/AAAAAAAAAR8/Uj0kJk7fTDM/s400/MP900411832.JPG)](http://4.bp.blogspot.com/-9EvATBIuyRw/UHaH6oylv6I/AAAAAAAAAR8/Uj0kJk7fTDM/s1600/MP900411832.JPG)\
(LOL @ Windows Clipart)

\
 I recently began experimenting with [nodejs](http://nodejs.org/) for a
small web scraping project. I wrote a tiny script that goes out to lots
of URLs and downloads files to disk. The simple solution was to iterate
through the list and send a request to load the URL and download the
page. \
\

### Too Many Open Files

Unfortunately, there are limits on the amount of simultaneous
[exec()](http://nodejs.org/api/child_process.html#child_process_child_process_exec_command_options_callback)
calls you can make. Since running an external command via exec() is
non-blocking, making too many back-to-back calls of it will result in
the following:

~~~~ {.brush: .bash}
node.js:201        throw e; // process.nextTick error, or error event on first tick              ^Error: spawn EMFILE    at errnoException (child_process.js:481:11)    at ChildProcess.spawn (child_process.js:444:11)    at child_process.js:342:9    at Object.execFile (child_process.js:252:15)    at child_process.js:220:18
~~~~

\

### Maximum Simultaneous Calls

To solve this, I implemented something like the following:

~~~~ {.brush: .js}
var queue = [];var MAX = 20;  // only allow 20 simultaneous exec callsvar count = 0;  // holds how many execs are runningvar urls = [...] // long list of urls// our callback for each exec callfunction wget_callback(err, stdout, stderr) {  count -= 1;    if (queue.length > 0 && count < MAX) {  // get next item in the queue!    count += 1;    var url = queue.shift();    exec('wget '+url, wget_callback);  }}urls.forEach( function(url) {  if (count < MAX) {  // go get the file!    count += 1;    exec('wget '+url, wget_callback);  } else {  // queue it up...    queue.push(url);  }});
~~~~

This will only allow so many exec() calls to simultaneously run. The
rest of the URLs will be stored in a queue until a slot becomes
available for them. Checking (and shifting) the queue is done in the
callback function **wget\_callback()**. I fetch the next URL to download
out of the **queue** only if there are no more than **MAX** exec() calls
already running. I keep track of how many calls are currently running
using **count** and increment/decrement accordingly. \
\
 I'm sure there are tons of libraries that do this, but I decided to
implement a quick and dirty solution to this problem and thought I'd
share!

---
layout: post
title: 'Quick Review: Basic Observer Design Pattern in Ruby'
date: '2012-12-22T16:04:00.000-08:00'
author: Frederick Ancheta
tags:
- ruby
- design pattern
- basic
- observer pattern
- oop
modified_time: '2012-12-22T16:09:53.757-08:00'
thumbnail: http://1.bp.blogspot.com/-hFt6SYM06D4/UNZCwbOLNcI/AAAAAAAAAVg/OjMODw0wp9c/s72-c/Observer%2BPattern.png
blogger_id: tag:blogger.com,1999:blog-9008563869490582540.post-6448738478372398199
blogger_orig_url: http://www.runtime-era.com/2012/12/basic-observer-design-pattern-in-ruby.html
---

\

[![](http://1.bp.blogspot.com/-hFt6SYM06D4/UNZCwbOLNcI/AAAAAAAAAVg/OjMODw0wp9c/s400/Observer%2BPattern.png)](http://1.bp.blogspot.com/-hFt6SYM06D4/UNZCwbOLNcI/AAAAAAAAAVg/OjMODw0wp9c/s1600/Observer%2BPattern.png)

\
 Every so often, it's nice to give yourself a quick review of basic
topics in software. Today, I wanted to review the
**[observer](http://www.oodesign.com/observer-pattern.html)** design
pattern and give a very simple implementation of it in Ruby. The
observer pattern allows several *observers* to be notified when an
observable object, or *subject*, changes its state. When the subject
sends an update notification, the observers can act accordingly based on
their type. \
\

### When to Observe

The observer pattern is useful for cases where an object is dependent on
the state of another. The subject manages a list of zero or more
observers made up of several types. Two common practical examples are:

-   graphical interface elements of an application will change based on
    the state of back-end data
-   a coupon subscription service will send notifications to several
    devices based on deals at different stores

\
\

### Observable (Subject)

We'll start by implementing the **Observable** module for our subject.
Remember, the subject is responsible for managing and notifying several
observers when its state changes.

~~~~ {.brush: .ruby}
module Observable  attr_accessor :state  def attachObserver(o)    @observers ||= []    @observers << o if !@observers.include?(o)  end  def removeObserver(o)    @observers.delete(o)  end  def state=(s)    @state = s    @observers.each do |o|      o.update(self) # more on update() later!    end  endend
~~~~

Let's break down the interesting parts:

~~~~ {.brush: .ruby}
def attachObserver(o)  @observers ||= []  @observers << o if !@observers.include?(o)enddef removeObserver(o)  @observers.delete(o)end
~~~~

These methods are used to manage the observers for our subject. We don't
want the same object in our list twice, so we only add an object if it
isn't already observing our subject.

~~~~ {.brush: .ruby}
def state=(s)  @state = s  @observers.each do |o|    o.update(self) # more on update() later!  endend
~~~~

When the subject changes its state, it needs to notify any object that
is observing it. We overwrite the default behavior for *state=*, which
is a method created for us by
[attr\_accessor](http://apidock.com/ruby/Module/attr_accessor). After
reassigning the state value, we call *update* on all the managed
observers. \
\

### Observer

Here is what our **Observer** module looks:

~~~~ {.brush: .ruby}
module Observer    def update(o)    raise 'Implement this!'  endend
~~~~

We leave the functionality of *update* to the class including our
module. This way, the Observer module behaves as an abstract class with
an interface that needs to be implemented by the includer. This gives us
the ability to include the Observer module into any class we want! \
\

### The Ant Colony

As a simple example, let's create an ant colony using our modules.
First, we define our **subject**, the Queen Ant:

~~~~ {.brush: .ruby}
class QueenAnt  include Observableend
~~~~

Next, let's define an **observer**:

~~~~ {.brush: .ruby}
class WorkerAnt  include Observer  def update(o)    p "I am working hard. Queen has changed state to #{o.state}!"  endend
~~~~

The WorkerAnt defines its own unique way of handling the state changes
of the queen. Let's create some worker ant objects to see how this
works:

~~~~ {.brush: .ruby}
queen = QueenAnt.newworker1 = WorkerAnt.newworker2 = WorkerAnt.newworker3 = WorkerAnt.newqueen.attachObserver(worker1)queen.attachObserver(worker2)queen.state = 'sleeping'# I am working hard. Queen has changed state to sleeping!" <-- worker1# I am working hard. Queen has changed state to sleeping!" <-- worker2
~~~~

When the queen changes state, the *worker1* and *worker2* instances get
notified and react accordingly. Since *worker3* was not attached, it
does not get notified. \
\
 The queen can handle any type of observer, not just WorkerAnts. Let's
create two additional observer classes:

~~~~ {.brush: .ruby}
class SoldierAnt  include Observer  def update(o)    p "Reporting for duty! Queen has changed state to #{o.state}!"  endendclass BreederAnt  include Observer  def update(o)    p "Need to look for a mate. Queen has changed state to #{o.state}!"  endend
~~~~

Now, let's create a soldier and breeder instance to observe the queen:

~~~~ {.brush: .ruby}
queen = QueenAnt.newsoldier = SoldierAnt.newbreeder = BreederAnt.newqueen.attachObserver(soldier)queen.attachObserver(breeder)queen.state = 'sleeping'# Reporting for duty! Queen has changed state to sleeping!# Need to look for a mate. Queen has changed state to sleeping!
~~~~

SoldierAnt and BreederAnt are different classes, but implement the same
Observer interface. When the queen changes her state, the two instances
(*soldier* and *breeder*) get notified and react accordingly. \
\
 There you have it! Please leave any questions, opinions, and/or
corrections below in the comments.

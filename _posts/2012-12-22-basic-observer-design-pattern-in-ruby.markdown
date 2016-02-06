---
layout: post
title: "Quick Review: Basic Observer Design Pattern in Ruby"
date: 2012-12-22
comments: true
---

[![Observer Pattern](/assets/images/posts/observer-pattern.png){: .bordered.landing-image.centered }](/assets/images/posts/observer-pattern.png)

Every so often, it's nice to give yourself a quick review of basic topics in software. Today, I wanted to review the **[observer](http://www.oodesign.com/observer-pattern.html)** design pattern and give a very simple implementation of it in Ruby. The observer pattern allows several *observers* to be notified when an observable object, or *subject*, changes its state. When the subject sends an update notification, the observers can act accordingly based on their type.

## When to Observe

The observer pattern is useful for cases where an object is dependent on the state of another. The subject manages a list of zero or more observers made up of several types. Two common practical examples are:

* graphical interface elements of an application will change based on the state of back-end data
* a coupon subscription service will send notifications to several devices based on deals at different stores

## Observable (Subject)

We'll start by implementing the `Observable` module for our subject.  Remember, the subject is responsible for managing and notifying several observers when its state changes.

{% highlight ruby %}
module Observable
  attr_accessor :state
 
  def attachObserver(o)
    @observers ||= []
    @observers << o if !@observers.include?(o)
  end
 
  def removeObserver(o)
    @observers.delete(o)
  end
 
  def state=(s)
    @state = s
    @observers.each do |o|
      o.update(self) # more on update() later!
    end
  end
end
{% endhighlight %}

Let's break down the interesting parts:

{% highlight ruby %}
def attachObserver(o)
  @observers ||= []
  @observers << o if !@observers.include?(o)
end
 
def removeObserver(o)
  @observers.delete(o)
end
{% endhighlight %}

These methods are used to manage the observers for our subject. We don't want the same object in our list twice, so we only add an object if it isn't already observing our subject.

{% highlight ruby %}
def state=(s)
  @state = s
  @observers.each do |o|
    o.update(self) # more on update() later!
  end
end
{% endhighlight %}

When the subject changes its state, it needs to notify any object that is observing it. We overwrite the default behavior for `state=`, which is a method created for us by [attr\_accessor](http://apidock.com/ruby/Module/attr_accessor). After reassigning the state value, we call `update` on all the managed observers.

## Observer

Here is what our `Observer` module looks:

{% highlight ruby %}
module Observer
  def update(o)
    raise 'Implement this!'
  end
end
{% endhighlight %}

We leave the functionality of `update` to the class including our module. This way, the Observer module behaves as an abstract class with an interface that needs to be implemented by the includer. This gives us the ability to include the Observer module into any class we want!

## The Ant Colony

As a simple example, let's create an ant colony using our modules.  First, we define our **subject**, the Queen Ant:

{% highlight ruby %}
class QueenAnt
  include Observable
end
{% endhighlight %}

Next, let's define an **observer**:

{% highlight ruby %}
class WorkerAnt
  include Observer

  def update(o)
    p "I am working hard. Queen has changed state to #{o.state}!"
  end
end
{% endhighlight %}

The `WorkerAnt` defines its own unique way of handling the state changes of the queen. Let's create some worker ant objects to see how this works:

{% highlight ruby %}
queen = QueenAnt.new

worker1 = WorkerAnt.new
worker2 = WorkerAnt.new
worker3 = WorkerAnt.new

queen.attachObserver(worker1)
queen.attachObserver(worker2)

queen.state = 'sleeping'
# I am working hard. Queen has changed state to sleeping!" <-- worker1
# I am working hard. Queen has changed state to sleeping!" <-- worker2
{% endhighlight %}

When the queen changes state, the `worker1` and `worker2` instances get notified and react accordingly. Since `worker3` was not attached, it does not get notified.

The queen can handle any type of observer, not just `WorkerAnt`s. Let's create two additional observer classes:

{% highlight ruby %}
class SoldierAnt
  include Observer

  def update(o)
    p "Reporting for duty! Queen has changed state to #{o.state}!"
  end
end

class BreederAnt
  include Observer

  def update(o)
    p "Need to look for a mate. Queen has changed state to #{o.state}!"
  end
end
{% endhighlight %}

Now, let's create a soldier and breeder instance to observe the queen:

{% highlight ruby %}
queen = QueenAnt.new

soldier = SoldierAnt.new
breeder = BreederAnt.new

queen.attachObserver(soldier)
queen.attachObserver(breeder)

queen.state = 'sleeping'
# Reporting for duty! Queen has changed state to sleeping!
# Need to look for a mate. Queen has changed state to sleeping!
{% endhighlight %}

`SoldierAnt` and `BreederAnt` are different classes, but implement the same `Observer` interface. When the queen changes her state, the two instances (`soldier` and `breeder`) get notified and react accordingly.

There you have it! Please leave any questions, opinions, and/or corrections below in the comments.

---
layout: post
title: 'SOLID Review: Interface Segregation Principle'
date: '2015-03-27T08:33:00.000-07:00'
author: Frederick Ancheta
tags:
- cohesion
- development
- software
- interface
- programming
- object oriented
- solid
- module
modified_time: '2015-03-27T08:33:36.448-07:00'
thumbnail: http://3.bp.blogspot.com/-GrMpVTN0_ZY/VNVXx74V5xI/AAAAAAAAD3U/t-LPYfNmiZM/s72-c/clutter.jpg
blogger_id: tag:blogger.com,1999:blog-9008563869490582540.post-4174968216245608109
blogger_orig_url: http://www.runtime-era.com/2015/03/solid-review-interface-segregation.html
---

[![](http://3.bp.blogspot.com/-GrMpVTN0_ZY/VNVXx74V5xI/AAAAAAAAD3U/t-LPYfNmiZM/s320/clutter.jpg)](http://3.bp.blogspot.com/-GrMpVTN0_ZY/VNVXx74V5xI/AAAAAAAAD3U/t-LPYfNmiZM/s1600/clutter.jpg)

\
 *Note: This is part of a series of articles reviewing the [five SOLID
Principles of object-oriented
programming](http://en.wikipedia.org/wiki/SOLID_%28object-oriented_design%29).*\
\
 The Interface Segregation Principle is probably the most
straight-forward of all the SOLID principles. It states: \
\
 **"Clients should not be forced to depend on methods that they do not
use."**\
\
 In dynamic languages, this isn't really much of an issue because there
is no way to define and force the implementation of interfaces on
classes ([like in
Java](http://docs.oracle.com/javase/tutorial/java/concepts/interface.html)).
Instead, **a set of methods** determines whether or not an object
implements an interface. If an object responds to "a particular set of
methods", it has implemented that "particular interface". \
\
 In Ruby, [modules](http://www.ruby-doc.org/core-2.2.0/Module.html) can
be used to define and share sets of methods across multiple classes.
Using this construct, we can define different "interfaces". So, when we
say "keep our interfaces segregated", we're really saying "keep our
modules segregated". This leads to highly cohesive modules. \
\
 There are two main benefits to cohesive modules in Ruby: **less
coupling** and **more readable code**. \
\

### Implementing Phones

By keeping our modules small and focused, we are simply applying the
[Single Responsibility
Principle](http://www.runtime-era.com/2015/02/solid-review-single-responsibility.html),
but for modules. For example, let's create a module called **Phone**:

~~~~ {.brush: .ruby}
module Phone  def call(number)    "Calling #{number}..."  end  def hangup    "Hanging up!"  end  def text(number, message)    "Texting '#{message}' to #{number}."  endend
~~~~

Here, we have a set of common behaviors for phones. We can make use of
this by including them in our class. Let's create a **CellPhone**:

~~~~ {.brush: .ruby}
class CellPhone  include Phoneend
~~~~

Now, our CellPhone class implements the methods in Phone! Any instance
of CellPhone can **call**, **hangup**, and **text** other numbers. \
\
 Let's create a new class called **RotaryPhone**:

~~~~ {.brush: .ruby}
class RotaryPhone  include Phone  # Eek... code smell.  def text(number, message)    raise 'Cannot text on this type of phone!'  endend
~~~~

Since we are overriding one of the methods in our module, it's a sign
our module isn't cohesive enough. Our RotaryPhone is being littered with
methods it does't need! \
\
 Another issue worth noting is the tight coupling between our two
classes caused by sharing the same, non-cohesive module. Suppose we
don't override the **text** method in RotaryPhone:

~~~~ {.brush: .ruby}
class RotaryPhone  include Phoneend
~~~~

Any errors caused by **text** in our Phone module would end up in both
classes, even though RotaryPhone doesn't care about **text**! This tight
coupling between CellPhone and RotaryPhone is unnecessary. \
\

### Segregate the Modules

A good solution for our problem is to *segregate* the basic phone
behaviors from the mobile phone behaviors:

~~~~ {.brush: .ruby}
module BasicPhone  def call(number)    "Calling #{number}..."  end  def hangup    "Hanging up!"  endendmodule MobilePhone  def text(number, message)    "Texting '#{message}' to #{number}."  endend
~~~~

Now, each of our classes implement only the modules they require:

~~~~ {.brush: .ruby}
class CellPhone  include BasicPhone  include MobilePhoneendclass RotaryPhone  include BasicPhoneend
~~~~

### A Readable, Loosely-Coupled Solution

The behaviors of each class are more clearly defined by the explicitness
of the modules it includes. Also, CellPhone and RotaryPhone are only
coupled by the methods in BasicPhone, which makes sense since they both
require the basic behaviors or **call** and **hangup**. Both of our
issues above are solved! \
\

### Conclusion

Although the Interface Segregation Principle is less important in
dynamic languages like Ruby, it still leads to cohesive, readable
classes. By keeping modules focused, we end up with looser coupling and
cleaner "interface" definitions. They aren't major wins, but wins
nonetheless! \
\
 Happy coding!

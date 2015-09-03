---
layout: post
title: 'Quick Review: Delegator Pattern in Java'
date: '2013-01-13T20:32:00.000-08:00'
author: Frederick Ancheta
tags:
- java
- design pattern
- delegation
modified_time: '2013-01-13T20:32:19.683-08:00'
thumbnail: http://3.bp.blogspot.com/-I96vdmqLQTw/UPOJo3buynI/AAAAAAAAAmw/7wBW3YwdIwk/s72-c/MP900430562.JPG
blogger_id: tag:blogger.com,1999:blog-9008563869490582540.post-4433507791419683712
blogger_orig_url: http://www.runtime-era.com/2013/01/quick-review-delegator-pattern-in-java.html
---

[![](http://3.bp.blogspot.com/-I96vdmqLQTw/UPOJo3buynI/AAAAAAAAAmw/7wBW3YwdIwk/s400/MP900430562.JPG)](http://3.bp.blogspot.com/-I96vdmqLQTw/UPOJo3buynI/AAAAAAAAAmw/7wBW3YwdIwk/s1600/MP900430562.JPG)

In the object-oriented world, there are times when our classes need to
share some or all of their functionality with others. There are many
different ways we can achieve this. Depending on the programming
language, we can tell our class to inherit its behavior from one or more
other classes. We might define and implement several interfaces. Many
dynamic languages allow "including" or "mixing in" behavior to share
functionality. \
\

### When to Delegate

[Delegation](http://en.wikipedia.org/wiki/Delegation_pattern) is useful
when we want a class to "borrow" only a small subset of methods from
another. Inheritance would solve the issue, but we might not want to
inherit *everything* from the parent class. Also, some languages,
[including
Java](http://javapapers.com/core-java/why-multiple-inheritance-is-not-supported-in-java/),
won't allow us to specify multiple parent classes. By using delegation,
we can *compose* the behavior of our class from any methods of our
choosing. \
\
 Delegation is also useful when we need our classes to dynamically
change their behavior at runtime. Some languages allow opening and
[redefining methods of any class or
object](http://runtime-era.blogspot.com/2012/12/reopen-and-modify-ruby-classes-monkey.html)
at any point during execution, but this becomes a maintenance nightmare.
The delegation pattern gives us a simple and straightforward way to
redefine object method behavior at runtime, even in static languages. \
\
 To summarize, use delegation when:

-   language constraints don't allow multiple inheritance
-   class behavior changes frequently at runtime

In general, it is best to use delegation when we want further decoupling
between method behavior and class definition. \
\

### MessageController (Delegator)

As a quick example, let's create a new class in a file called
**MessageController.java**:

~~~~ {.brush: .java}
class MessageController {  Message messageDelegate = new TextMessage();  String message = "Default Message";  public void displayMessage() {    this.messageDelegate.displayMessage(this.message);  }  public void setMessageDelegate(Message m) {    this.messageDelegate = m;  }  public void setMessage(String s) {    this.message = s;  }}
~~~~

This class is responsible for holding a message and displaying a
message. Displaying and setting the message is straightforward. The
interesting parts have to do with the *type* of message the instance of
this class represents. This is dictated by the type of **Message**
stored in **messageDelegate**. \
\

### TextMessage, PictureMessage, and VoiceMessage (Delegates)

The types of messages our controller can handle are defined as our
delegates. The delegator needs a general way to invoke each delegate.
So, we'll create a common interface: \
\
 **Message.java**:

~~~~ {.brush: .java}
interface Message {  void displayMessage(String s);}
~~~~

Now, we can define our delegates: \
\
 **TextMessage.java**:

~~~~ {.brush: .java}
class TextMessage implements Message {  public void displayMessage(String s) {    System.out.println("A Text Message: " + s);  }}
~~~~

**PictureMessage.java**:

~~~~ {.brush: .java}
class PictureMessage implements Message {  public void displayMessage(String s) {    System.out.println("A Picture Message: " + s);  }}
~~~~

**VoiceMessage.java**:

~~~~ {.brush: .java}
class VoiceMessage implements Message {  public void displayMessage(String s) {    System.out.println("A Voice Message: " + s);  }}
~~~~

Each delegate implements its own unique way to display a message, but
the method name remains consistent because of our interface. \
\

### One Controller, Many Behaviors

Now, we can see how the delegation pattern allows us to pick and choose
behaviors from any class we want at runtime. Let's drive our
**MessageController** with a simple program: \
\
 **Main.java**:

~~~~ {.brush: .java}
class Main {  public static void main(String[] args) {    MessageController mc = new MessageController();    mc.displayMessage();    // A Text Message: Default Message    mc.setMessageDelegate(new PictureMessage());    mc.setMessage("Look, a picture!");    mc.displayMessage();    // A Picture Message: Look, a picture!    mc.setMessageDelegate(new VoiceMessage());    mc.setMessage("Listen to my voice...");    mc.displayMessage();    // A Voice Message: Listen to my voice...  }}
~~~~

Simple enough? Please leave any questions or comments below! There are
more complex examples in the [Cocoa Fundamentals
Guide](https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/CocoaFundamentals/CommunicatingWithObjects/CommunicateWithObjects.html#//apple_ref/doc/uid/TP40002974-CH7-SW18),
as delegation is used heavily in the UI for Mac OSX.

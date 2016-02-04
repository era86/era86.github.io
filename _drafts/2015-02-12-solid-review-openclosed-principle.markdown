---
layout: post
title: 'SOLID Review: Open/Closed Principle'
date: 2015-02-12
comments: true
---

[![OCP](/assets/images/posts/ocp.png){: .bordered.landing-image.centered }](/assets/images/posts/ocp.png)

*Note: This is part of a series of articles reviewing the [five SOLID Principles of object-oriented programming](http://en.wikipedia.org/wiki/SOLID_%28object-oriented_design%29).*

The Open/Closed Principle was first coined by Bertrand Meyer in his book [Object Oriented Software Construction](http://www.amazon.com/Object-Oriented-Software-Construction-CD-ROM-Edition/dp/0136291554).  Meyer states that the implementation of any class in a system should be changed only to correct errors. Any new features are introduced by creating additional classes that extend or modify the existing code.

 Meyer's idea is more popularly described as follows:

> "Software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification."

Following this principle brings a major benefit. We are less likely to break the existing system's functionality if we minimize any changes to the original implementation. This increases stability, extensibility, and maintainability.

## Open for Extension, Closed for Modification

Classes abiding by the Open/Closed Principle exhibit two important characteristics: they are **open for extension** and **closed for modification**.

A class is **closed for modification** when its internal implementation is hidden away. Its only interactions with the outside world are through a set of public methods known as its interface. All its internal logic is assumed to be correct. Therefore, it shouldn't need to change.

A class is **open for extension** if its behavior can be enhanced or modified by adding new code on top of the existing implementation.  Classes must be designed in a way that lets consumers "plug in" or "inject" new logic.

## Abstracting Behaviors

The main key in adhering to the Open/Closed Principle is proper abstraction of key behaviors. These behaviors are abstracted and encapsulated nicely behind a shared interface. By keeping classes dependent on these abstractions, new behaviors can easily be introduced without changing the existing code.

## A Simple String Transformer

Suppose we need a simple application that transforms strings. Somewhere in our code, we have a service object called `Transformer` which takes a string and transforms it into a some other object:

{% highlight ruby %}
require 'json'
 
class Transformer
  def initialize(string)
    @string = string
  end
 
  def transformed_string
    JSON.parse(@string)
  end
end
 
Transformer.new('{"foo": "bar"}').transformed_string
# { "foo" => "bar" }
{% endhighlight %}

Simple enough! We can transform strings into Ruby hashes. Now, a new feature requires us to transform strings into binary in addition to Ruby hashes. Let's add the new functionality to our `Transformer` class: 

{% highlight ruby %}
require 'json'
 
class Transformer
  def initialize(string, type)
    @string = string
    @type = type
  end
 
  def transformed_string
    if @type == :json
      JSON.parse(@string)
    elsif @type == :binary
      @string.unpack('B*').first
    end
  end
end
 
Transformer.new('Hello', :binary).transformed_string
# "0100100001100101011011000110110001101111"
{% endhighlight %}

Great! Now we can pass in strings and specify the type of transformation to use. So far, so good. However, yet another new feature requires us to add support for yet *another* transformation: converting to MD5.

{% highlight ruby %}
require 'json'
require 'digest'
 
class Transformer
  def initialize(string, type)
    @string = string
    @type = type
  end
 
  def transformed_string
    if @type == :json
      JSON.parse(@string)
    elsif @type == :binary
      @string.unpack('B*').first
    elsif @type == :md5
      Digest::MD5.hexdigest @string
    end
  end
end
 
Transformer.new('Hello', :md5).transformed_string
# "8b1a9953c4611296a827abf8c47804d7"
{% endhighlight %}

As you can see, our `transformed_string` method is starting to get quite ugly. It is also brittle, as we keep modifying the logic inside to accommodate new features! How can we make this class more open to extension?

## Find and Extract the Abstraction

To make Transformer more open to extension, we need to make it depend on an abstract behavior rather than handling many different transformations. It seems like we keep on adding new types of transformations to our class, so let's abstract this behavior out!

### Solution: Inheritance

We'll start by turning our `Transformer` into an abstract base class.

{% highlight ruby %}
class Transformer
  def initialize(string, type)
    @string = string
    @type = type
  end
 
  def transformed_string
    raise 'Implement me!'
  end
end
{% endhighlight %}

The class looks the same. However, the application will now depend on `Transform`'s sub-classes to implement the `transformed_string` behavior. Taking this approach, we can now create new types of transformations by adding new classes:

{% highlight ruby %}
class MD5Transformer < Transformer
  def transformed_string
    Digest::MD5.hexdigest @string
  end
end
 
MD5Transformer.new('Hello').transformed_string
# "8b1a9953c4611296a827abf8c47804d7"
{% endhighlight %}

However, we've almost completely rewrote our existing implementation to make way for this solution. What about other classes in our application that depended on instances of Transformer? We would have to change class-names and signatures all over our application to accommodate our refactor.

### Better Solution: Dependency Injection

Again, we want to extract and encapsulate the transformation behavior out and make Transform depend on an abstraction. We can achieve this by creating different `Transformation`s and *injecting* them into Transform through its constructor:

{% highlight ruby %}
class Transformer
  def initialize(string, transformation)
    @string = string
    @transformation = transformation
  end
 
  def transformed_string
    @transformation.transform(string)
  end
end
 
class BinaryTransformation
  def self.transform(string)
    string.unpack('B*').first
  end
end
 
Transformer.new('Hello', BinaryTransformation).transformed_string
# "0100100001100101011011000110110001101111"
{% endhighlight %}

This is a bit better, as the signature of our constructor hardly changes, but the implementation of Transform now depends on an abstraction known as `Transformation`. Any new (or existing) transformation behaviors can be added by creating new classes and injecting them into `Transform`!

{% highlight ruby %}
require 'json'
require 'digest'
 
class JSONTransformation
  def self.transform(string)
    JSON.parse(string)
  end
end
 
Transformer.new('{"foo": "bar"}', JSONTransformation).transformed_string
# { "foo" => "bar" }
 
class MD5Transformation
  def self.transform(string)
    Digest::MD5.hexdigest string
  end
end
 
Transformer.new('Hello', MD5Transformation).transformed_string
# "8b1a9953c4611296a827abf8c47804d7"
{% endhighlight %}

## Conclusion

This is a very simple example of how to design classes that are open for extension and closed for modification. It's important to remember to **balance this principle against real-life requirements**. If applied too soon, the Open/Closed Principle might lead to unnecessary abstractions, making code difficult to understand. **Always take the simplest approach first**. Then, if necessary, refactor code with the Open/Closed principle in mind.

Happy coding!

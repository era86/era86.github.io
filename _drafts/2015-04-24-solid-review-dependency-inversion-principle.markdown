---
layout: post
title: 'SOLID Review: Dependency Inversion Principle'
date: 2015-04-24
comments: true
---

[![Plug](/assets/images/posts/plug.jpg){: .bordered.landing-image.centered }](/assets/images/posts/plug.jpg)

*Note: This is part of a series of articles reviewing the [five SOLID Principles of object-oriented programming](http://en.wikipedia.org/wiki/SOLID_%28object-oriented_design%29).*

The final SOLID principle is known as the Dependency Inversion principle. Arguably the most important of the five principles, the Dependency Inversion principle can be thought of as a culmination of the principles preceding it. Systems that abide by the other SOLID principles tend to follow the Dependency Inversion principle as a result. The principle states:  

> "High-level modules should not depend on low-level modules."

A better way to think about it is:  

> "Abstractions should not depend upon details. Details should depend upon abstractions."

In a static-typed language like Java, "abstractions" can be implemented and enforced explicitly via [interfaces](http://docs.oracle.com/javase/tutorial/java/concepts/interface.html). However, in a dynamic language like Ruby, we depend on [duck-typing](http://en.wikipedia.org/wiki/Duck_typing) to describe an object's interface. Even without explicit interfaces in Ruby, the Dependency Inversion principle still holds value! We should still aim to **depend on abstractions rather than details**.  

Let's look at an example! We'll revisit a simple example from my [blog post on the Open/Closed Principle](http://www.runtime-era.com/2015/02/solid-review-openclosed-principle.html).  

## A Simple String Transformer

Suppose we have a class called `Transformer` that takes a string and transforms it into a some other object or value. For starters, we'll have it transform JSON strings into Ruby hashes:

{% highlight ruby %}
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

Now, we'll extend the functionality of our `Transformer` by allowing it to transform strings into binary:

{% highlight ruby %}
class Transformer
  def initialize(string)
    @string = string
  end

  def transformed_string(type)
    if type == :json
      JSON.parse(@string)
    elsif type == :binary
      @string.unpack('B*').first
    end
  end
end

Transformer.new('Hello').transformed_string(:binary)
# "0100100001100101011011000110110001101111"
{% endhighlight %}

Now, our `Transformer` takes strings and transforms them into one of two different types: a Ruby hash or its binary representation. At this point, we should notice some code-smell! The `transformed_string` method is very dependent on `JSON.parse` and `String.unpack`. These are implementation details that our Transformer shouldn't care about.  

Let's apply the Dependency Inversion principle by making `Transformer` depend on _an abstraction_ rather than coupling to concrete details!  

## The Transformation Abstraction

The basic functionality of our `Transformer` class is to transform strings into several different types of objects or values. It does this by utilizing different _transformations_. This seems like an abstraction we can extract and encapsulate! We'll make `Transformer` depend on a new abstraction called `Transformation`:

{% highlight ruby %}
class Transformer
  def initialize(string)
    @string = string
  end

  def transformed_string(transformation)
    transformation.transform(string)
  end
end

class BinaryTransformation
  def self.transform(string)
    string.unpack('B*').first
  end
end

Transformer.new('Hello').transformed_string(BinaryTransformation)
# "0100100001100101011011000110110001101111"

require 'json'

class JSONTransformation
  def self.transform(string)
    JSON.parse(string)
  end
end

Transformer.new('{"foo": "bar"}').transformed_string(JSONTransformation)
# { "foo" => "bar" }
{% endhighlight %}

Rather than having `Transformer` depend on low-level implementation details (`JSON.parse` and `String.unpack`), it now depends on a single method: `transform`. This single method is what makes up the interface of our `Transformation` abstraction! Now, we can create as many `Transformation`s as we want without modifying `Transformer`:

{% highlight ruby %}
require 'digest'

class MD5Transformation
  def self.transform(string)
    Digest::MD5.hexdigest string
  end
end

Transformer.new('Hello').transformed_string(MD5Transformation)
# "8b1a9953c4611296a827abf8c47804d7"
{% endhighlight %}

## Conclusion

As you can see, the [Open/Closed principle](http://www.runtime-era.com/2015/02/solid-review-openclosed-principle.html) is highly correlated with the Dependency Inversion principle! We actually end up following the Open/Closed principle by abiding by the Dependency Inversion principle. In fact, some form of dependency abstraction is often required to abide by all the other SOLID principles. If there's one principle to remember out of all the SOLID principles, it's the Dependency Inversion principle: **depend on abstractions, not low-level details**!  

Happy coding!

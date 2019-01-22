---
layout: post
title:  "Features in Ruby I Miss While Working in Python"
date:   2019-01-22
landing-image: "/assets/images/posts/ruby-python-logo.png"
comments: true
---

[![Ruby vs Python]({{ page.landing-image }}){: .landing-image.centered }]({{ page.landing-image }})

For about six years, I worked primarily on the Ruby on Rails stack. For me, [Ruby](https://www.ruby-lang.org/en/) was (and still is) a great language for learning programming concepts like test-driven development and object-oriented design patterns. Its syntax is "human-friendly" and great for beginners to read and understand.

Recently, I moved back over to [Python](https://www.python.org/) and Django. Python is a much more _direct_ programming language than Ruby. It emphasizes simplicity, making everything as obvious and explicit to the programmer, even if it's verbose.

Both Ruby and Python, though different in their philosophies, are a joy for programming! They're easy to learn and enable software developers to be productive very quickly. However, there are some features of Ruby I miss while working in Python. These are just a few I thought I'd share.

## Functional approach to working with lists/arrays

### Python:

In Python, iterating through lists often involves a standard `for`-loop. Python also has a nice feature for building lists called [list comprehensions](https://www.programiz.com/python-programming/list-comprehension).

{% highlight python %}
engineers = [e for e in employees if e.department == 'engineering'] # filter
engineer_salaries = [e.salary for e in engineers] # map
sum(engineer_salaries) # reduce
{% endhighlight %}

### Ruby:

Ruby's way of operating on arrays feels a bit more intuitive. Its functional-first approach is very straightforward to read and write, especially when chaining multiple operations together. 

{% highlight ruby %}
employees
  .select { |e| e.department == 'engineering' } # filter
  .collect { |e| e.salary } # map
  .sum # reduce
{% endhighlight %}

Ruby also has [many built-in methods](https://ruby-doc.org/core-2.6/Enumerable.html) for working with native enumerable data types. This makes working with arrays _really_ easy from the start!

## Explicit private methods

[Encapsulation](https://stackify.com/oop-concept-for-beginners-what-is-encapsulation/) is an important concept in object-oriented programming. The ability to define and enforce private methods lets programmers declare the intended interface for any particular class.

### Python:

There are [philosophical reasons](https://mail.python.org/pipermail/tutor/2003-October/025932.html) for Python's lack of private methods. However, a similar effect can be achieved using a Python concept called [name mangling](https://docs.python.org/3.5/tutorial/classes.html#private-variables). Just prefix "private" methods with double-underscores.

{% highlight python %}
class MyClass:
  def allowed(self):
      return "allowed"

  def __not_allowed(self):
      return "not allowed"

MyClass().__not_allowed()
# AttributeError: MyClass instance has no attribute '__not_allowed'
{% endhighlight %}

### Ruby:

In Ruby, private methods are declared with the [`private`](https://ruby-doc.org/core-2.6/Module.html#method-i-private) keyword.

{% highlight ruby %}
class MyClass
  def allowed
    "allowed"
  end

  private

  def not_allowed
    "not allowed"
  end
end

MyClass.new.not_allowed
# '<main>': private method `not_allowed' called for #<MyClass:0x000056424b2346f8> (NoMethodError)
{% endhighlight %}

Although the functionality is somewhat the same, I prefer Ruby's explicit `private` keyword over Python's naming convention.

## Modules and mix-ins for abstracting functionality

Building abstractions and sharing them across classes is a common way to keep code [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) (don't repeat yourself).

### Python:

In Python, integrating cohesive logic from more than one abstraction is commonly achieved with [multiple inheritance](https://www.programiz.com/python-programming/multiple-inheritance).

{% highlight python %}
class Adder:
    def add(self, x, y):
        return x + y

class Multiplier:
    def multiply(self, x, y):
        return x * y

class Calculator(Adder, Multiplier):
    pass

c = Calculator()
print c.add(1, 1) # 2
print c.multiply(2, 2) # 4
{% endhighlight %}

### Ruby:

Ruby doesn't support multiple inheritence. However, it accomplishes this behavior by implementing a mechanism called [mix-ins](https://www.tutorialspoint.com/ruby/ruby_modules.htm).

{% highlight ruby %}
module Addable
  def add(x, y)
    x + y
  end
end

module Multipliable
  def multiply(x, y)
    x * y
  end
end

class Calculator
  include Addable
  include Multipliable
end

c = Calculator.new
p c.add(1, 1) # 2
p c.multiply(2, 2) # 4
{% endhighlight %}

In Ruby, modules are "mixed in" with classes, making objects "act like" the desired abstractions. In Python, classes are "inherited", making objects "become" the desired abstractions. Creating and sharing modules for the purpose of encapsulating _behavior_ feels cleaner and more semantic than creating classes.

## In-line variable string interpolation

### Python:

Interpolating variables in Python can be achieved with [`str.format()`](https://realpython.com/python-string-formatting/#2-new-style-string-formatting-strformat).

{% highlight python %}
"Hello, {}! Welcome to {}.".format(employee_name, company_name)
{% endhighlight %}

### Ruby:

[String interpolation in Ruby](https://www.digitalocean.com/community/tutorials/how-to-work-with-strings-in-ruby#using-string-interpolation) is similar, but Ruby has the advantage of interpolating variables _in-place_.

{% highlight ruby %}
"Hello, #{employee_name}! Welcome to #{company_name}."
{% endhighlight %}

It's a subtle difference, but it makes for a better reading experience.

_Note: Those who are fortunate enough to be using Python 3.6+ can get a similar experience with [`f`-strings](https://realpython.com/python-string-formatting/#3-string-interpolation-f-strings-python-36)!_

## Conclusion

There is [no](https://learn.onemonth.com/ruby-vs-python/) [shortage](https://hackernoon.com/ruby-vs-python-the-definitive-faq-5cb0046292be) of [articles](https://www.nascenia.com/why-choose-ruby-on-rails-over-python/) on the web comparing and contrasting Ruby and Python. As with anything in programming, as long as things are done idiomatically, both are great for developing software.

Do you also have experience with Ruby _and_ Python? Share your thoughts and comment below!

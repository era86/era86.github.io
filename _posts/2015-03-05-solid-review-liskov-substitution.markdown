---
layout: post
title: 'SOLID Review: Liskov Substitution Principle'
date: 2015-03-05
landing-image: "/assets/images/posts/duck.jpg"
comments: true
---

[![Duck](/assets/images/posts/duck.jpg){: .bordered.landing-image.centered }](/assets/images/posts/duck.jpg)

 *Note: This is part of a series of articles reviewing the [five SOLID Principles of object-oriented programming](http://en.wikipedia.org/wiki/SOLID_%28object-oriented_design%29).*

Barbara Liskov introduced her substitution principle back in 1987 during her keynote titled [Data Abstraction and Heirarchy](http://rendezvouswithdestiny.net/index_files/LiskovSub.pdf). Today, it is one of the five SOLID principles in object-oriented programming. The original definition is as follows:

> "Let q(x) be a property provable about objects x of type T. Then q(y) is provable for objects y of type S, where S is a subtype of T."

Simply put:

> "Instances of any type should be replaceable by instances of its subtypes without creating incorrect behaviors."

How can we ensure that our classes abide by the Liskov Substitution Principle? For starters, we must ensure that any subtype implements the interface of its base type. In the world of dynamic languages, this is better stated as **a subtype must *respond to* the same set of methods as its base type**.

We must also ensure that methods in any subtype **preserve the original *promises* of methods in its base type**. What "promises" are we talking about? For that, we turn to another design principle known as **Design by Contract**.

## Design by Contract

The concept of [Design by Contract](http://en.wikipedia.org/wiki/Design_by_contract) was coined by Bertrand Meyer in his book [Object Oriented Software Construction](http://www.amazon.com/Object-Oriented-Software-Construction-CD-ROM-Edition/dp/0136291554). It's official description is much more detailed, but to paraphrase, there are three basic principles:

* Subtypes **should not strengthen any preconditions** of its base type. That is, requirements on inputs to a subtype cannot be stricter than in the base type.
* Subtypes **should not weaken any postconditions** of its base type. That is, the possible outputs from a subtype must be more than or equally restrictive as from the base class.
* Subtypes must **preserve all invariants** of its base type. That is, if the base type has guarantees that certain conditions be true, its subtype should make those same guarantees.

If any of the above are violated, chances are the Liskov Substitution Principle is also violated.

## A Liskov Substitution Checklist

Let's look at a simple example. We're going to model several types of birds. We'll start by defining a base type called `Bird`:

{% highlight ruby %}
class Bird
  def initialize
    @flying = false
  end
 
  def eat(food)
    if ['worm', 'seed'].include?(food)
      "Ate #{food}!"
    else
      raise "Does not eat #{food}!"
    end
  end
 
  def lay_egg
    # The Egg class has a method 'hatch!' that returns a new Bird.
    Egg.new
  end
 
  def fly!
    @flying = true
  end
end
{% endhighlight %}

Instances of `Bird` are very simple. They eat only certain types of food, lay eggs, and can go from sitting on the ground to flying in the air. For now, ignore the fact that our Bird cannot go back on the ground. Here's a small program that uses our `Bird`:

{% highlight ruby %}
bird = Bird.new
 
bird.eat('worm') # Ate worm!
 
egg = bird.lay_egg # Returns an Egg
egg.hatch! # Returns a new Bird
 
bird.fly! # @flying == true
{% endhighlight %}

Remember, any subtypes from `Bird` should be able to work in our program above. Now, let's create some subtypes of `Bird` and see how we can apply the Liskov Substitution Principle.

### The subtype must implement the base type's interface.

In most programming languages, we can achieve this through basic inheritance. Since we already have a base class defined, we'll take this approach. However, there are many ways to achieve this across many languages. In Ruby, we can use [modules](http://www.ruby-doc.org/core-2.2.0/Module.html) to share methods (see [duck-typing](http://en.wikipedia.org/wiki/Duck_typing)). In Java, we can implement [interfaces](http://docs.oracle.com/javase/tutorial/java/concepts/interface.html).

Let's create a `Pigeon` subclass:

{% highlight ruby %}
class Pigeon < Bird
end
 
bird = Pigeon.new # Behaves exactly like Bird!
{% endhighlight %}

Success! `Pigeon` now implements `Bird`'s interface.

### The subtype should not strengthen preconditions of the base type.

Let's say our `Pigeon`s can only eat bread. We will override the `eat`
method to achieve this:

{% highlight ruby %}
class Pigeon < Bird
  def eat(food)
    if ['bread'].include?(food)
      "Ate #{food}!"
    else
      raise "Does not eat #{food}!"
    end
  end
end
 
# bird is now Pigeon
bird.eat('worm') # raises an error: "Does not eat worm!"
{% endhighlight %}

Since we've actually **made the preconditions to our method stricter** than in the `Bird` class, we've violated the Liskov Substitution Principle! In doing so, we've broken our existing program!

Instead, let's say that `Pigeon`s can eat bread *in addition* to seeds and worms. Then, we've *weakened* the preconditions and are well within our rule:

{% highlight ruby %}
class Pigeon < Bird
  def eat(food)
    if ['worm', 'seed', 'bread'].include?(food)
      "Ate #{food}!"
    else
      raise "Does not eat #{food}!"
    end
  end
end
 
bird.eat('worm') # "Ate worm!"
{% endhighlight %}

And our program works with our subclass!

### The subtype should not weaken postconditions of the base type.

Let's say our `Pigeon` is some kind of mutant and doesn't actually lay eggs. We'll call it a `MutantPigeon`. Instead, no egg comes out at all:

{% highlight ruby %}
class MutantPigeon < Bird
  def lay_egg
    nil
  end
end
 
bird = MutantPigeon.new
 
egg = bird.lay_egg # returns nil
egg.hatch! # raises an error: undefined method 'hatch!' for nil:NilClass
{% endhighlight %}

We've broken our program yet again! Since we've actually **made the postconditions in our method less restrictive** than in the `Bird` class, we've violated the Liskov Substitution Principle.

Instead, let's say that `MutantPigeons` actually return a *more specific* type of `Egg`. We'll call it `MutantPigeonEgg`, and it behaves just like Egg with a `hatch!` method. Then, we've *strengthened* the postconditions and are well within our rule:

{% highlight ruby %}
class MutantPigeon < Bird
  def lay_egg
    MutantPigeonEgg.new
  end
end
 
egg = bird.lay_egg # returns nil
egg.hatch! # Returns a new MutantPigeon
{% endhighlight %}

And our program is happy again!

### The subtype should preserve invariants of the base type.

Let's model a different bird this time. What about `Penguin`s? As many people know, most penguins in the real world don't actually fly. So, we'll override the `fly` method with a no-op:

{% highlight ruby %}
class Penguin < Bird
  def fly
    # no-op, do nothing
  end
end
 
bird = Penguin.new
 
bird.fly! # @flying != true
{% endhighlight %}

Looks like another break in our program! By doing nothing in our new `fly` method, we've **broken the guarantee** that the state of our `@flying` variable would be `true`. Again, we've violated the Liskov Substitution Principle.

Now, this introduces an interesting problem. Penguins cannot just be made to fly, right?!

### Real-Life Relationships != Inheritance-Model Relationships

Objects in the real world may show an obvious inheritance relationship. However, in object-oriented design, we only care about inheritance relationships regarding object *behavior*. Think of the classes in our system as **representations** of real-world objects. Those representations are fully defined by their external behavior (or interface).

Sure, penguins are birds in the real world, but `Penguin`s *are not* `Bird`s in our system because they do not *behave* like `Bird`s. They don't have a properly functioning `fly` method.

### Liskov Substitution and the Open/Closed Principle

Consider the examples above. Suppose we actually violated the Liskov Substitution Principle by creating our `Pigeon` class with a more restrictive `eat` method? Our existing program would have to be modified to handle our new class:

{% highlight ruby %}
class Pigeon < Bird
  def eat(food)
    if ['bread'].include?(food)
      "Ate #{food}!"
    else
      raise "Does not eat #{food}!"
    end
  end
end
 
if bird.instance_of?(Pigeon)
  bird.eat('bread') # "Ate bread!"
else
  bird.eat('worm') # "Ate worm!"
end
{% endhighlight %}

As we know from the Open/Closed Principle, we shouldn't have to change existing code to add new requirements or features. By violating the Liskov Substitution Principle, we are forced to violate the Open/Closed Principle!

## Conclusion

As with all programming principles, it's important to find a balance when applying the Liskov Substitution Principle in real-world scenarios. There is [some debate](http://c2.com/cgi/wiki?LiskovSubstitutionPrinciple) over the benefits or detriments of the principle. Always keep it simple first, then refactor as needed.

Happy coding!

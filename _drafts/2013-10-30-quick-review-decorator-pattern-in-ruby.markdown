---
layout: post
title: 'Quick Review: Decorator Pattern in Ruby'
date: 2013-10-30
comments: true
---

[![Ornament](/assets/images/posts/ornament.gif){: .bordered.landing-image.centered }](/assets/images/posts/ornament.gif)

In the object-oriented world, simple applications usually require small classes with static behaviors. Adding, modifying, and sharing those behaviors can be achieved by mixing in modules or inheriting from other classes at compile time. However, more complex applications might require a particular instance of a class to gain additional functionality at runtime. To modify the behavior of an object dynamically, we can utilize the [decorator](http://en.wikipedia.org/wiki/Decorator_pattern) design pattern.

## When to Decorate

Decoration can be used to add behavior to any individual object without affecting the behavior of other objects of the same class. Essentially, the existing object is being "wrapped" with additional functionality. Some practical problems that can be solved by decoration are:

-   applying one or more UI elements to a specific UI widget at runtime
-   saving an ActiveRecord model in various ways based on conditionals
    in a Rails controller
-   adding additional information to data streams by pre/appending with
    additional stream data

To properly implement a decorator, it must adhere to the following guidelines:

-   The decorator must **implement the original object's interface**.
-   The decorator must **delegate any methods to the decorated object**.

The first guideline makes sure a decorator remains transparent to any clients of the original object. As far as the clients know, the decorated object hasn't changed in terms of its interface. The second guideline makes sure the decorator adds behavior before or after delegating the message to the wrapped object. This allows decorators to be stacked on top of one another, building on the original objects behavior.

Now, there are [several ways](http://robots.thoughtbot.com/post/14825364877/evaluating-alternative-decorator-implementations-in) to implement the decorator pattern in Ruby, but I'll only cover my two favorite methods. The first is a very basic implementation using only Ruby wrapper classes on objects. The second uses modules and `extend` to add functionality to objects.

## Race Cars

Let's start by defining the base class. We'll use race cars as a starting point, then add some performance upgrades by using decorators.  Here is our `RaceCar` class:

{% highlight ruby %}
class RaceCar
  def initialize(make, model)
    @make  = make
    @model = model
  end
 
  def name
    "#{@make} #{@model}"
  end
 
  def horsepower
    200
  end
end
{% endhighlight %}

Now, we can create a race car:

{% highlight ruby %}
car = RaceCar.new('Dodge', 'Charger')
 
car.name
# Dodge Charger
 
car.horsepower
# 200
{% endhighlight %}

## TurboCharge Wrapper

Race car garages can increase horsepower by adding different parts to their vehicles. Using a simple wrapper, let's create a `TurboCharge` decorator class that takes a `RaceCar` object and increases its horsepower by 30:

{% highlight ruby %}
class TurboCharge
  def initialize(race_car)
    @race_car = race_car
  end

  def horsepower
    @race_car.horsepower + 30
  end
end
{% endhighlight %}

Now, we can use this class to decorate our `car`:

{% highlight ruby %}
turbo_car = TurboCharge.new(car)

turbo_car.horsepower
# 230
{% endhighlight %}

This is very straightforward and achieves the desired behavior, but breaks the first guideline of decorators. For instance, what happens when we try to treat it like a `RaceCar`?

{% highlight ruby %}
turbo_car.name
# undefined method 'name' for TurboCharge (NoMethodError) ...
{% endhighlight %}

Remember, **we have to implement the original interface** of the object we are decorating! Our decorator class, as it stands, is incomplete. We can remedy this by implementing `name` on it and delegating down to the original object:

{% highlight ruby %}
class TurboCharge
  ...

  def name
    @race_car.name
  end
end
{% endhighlight %}

Now, it behaves correctly:

{% highlight ruby %}
turbo_car.name
# Dodge Charger
{% endhighlight %}

What if our original object has a ton of methods? It would be quite painful to re-implement all of the methods and delegate them down.  However, if the application does not require all methods in the original object to function, you can simply add the ones that are needed. This is when best judgement should be used. Sometimes, **the simplicity of implementing wrapper classes outweighs the need to to provide absolute transparency**.

## TurboCharge Module

Let's say transparency is very important. Well, there's another way to add behaviors dynamically without losing the original interface of the decorated object We can create a TurboCharge module and `extend` any instance of `RaceCar` with it:

{% highlight ruby %}
module TurboCharge
  def horsepower
    super + 30 # 'super' refers to the original object's horsepower method
  end
end
{% endhighlight %}

Modules are usually used to share similar functionality across multiple class definitions. In our case, we want to add functionality to an instance. We can "mix in" our TurboCharge module to any object by using [`extend`](http://ruby-doc.org/core-2.0.0/Object.html#method-i-extend).  Using this method, we can decorate to our `RaceCar` instance without changing how it originally behaves:

{% highlight ruby %}
car.extend(TurboCharge)

car.horsepower
# 230

car.name
# Dodge Charger
{% endhighlight %}

Voila!

## Decorating Your Way

When I decide to decorate, I'll usually start with the wrapper approach first. This allows me to be explicit in designing the interface of my decorated object. However, if I find it is too painful to try and recreate the original interface as the application requires, I'll opt for *extend*ing the object with a decorator module. Adjust the design pattern to fit your needs!

Questions? Comments? Let me know below or send me a Tweet. Thanks for reading!

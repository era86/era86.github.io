---
layout: post
title:  "Ruby OpenStruct-like Objects in Python with namedtuple"
date:   2020-03-30
landing-image: "/assets/images/posts/wood-cubes.jpg"
comments: true
---

[![]({{ page.landing-image }}){: .bordered.landing-image.centered }]({{ page.landing-image }})

In object-oriented programming, classes are how we define objects and specify their data attributes. Sometimes, we want to create objects with attributes "on the fly", without having go through the boilerplate of defining a new [class](https://en.wikipedia.org/wiki/Class_(computer_programming)). For example, creating [mock objects](https://en.wikipedia.org/wiki/Mock_object) in tests.

Let's say we want to create a city object with the following properties:

* name
* population
* region

And we want to do this _quickly_, without having to define a new class.

## Ruby

In Ruby, an [`OpenStruct`](https://ruby-doc.org/stdlib-2.5.1/libdoc/ostruct/rdoc/OpenStruct.html) can be used for this purpose.

{% highlight ruby %}
require 'ostruct'

city = OpenStruct.new(
  name: 'Rivendell',
  population: 100,
  region: 'Eriador'
)

city.name # Rivendell
city.population # 100
city.region # Eriador
{% endhighlight %}

## Python

It's not quite as succinct, but [`namedtuple`](https://docs.python.org/3/library/collections.html#collections.namedtuple) in Python can be used to achieve a similar effect.

{% highlight python %}
from collections import namedtuple

City = namedtuple('City', [
  'name',
  'population',
  'region'
])

city = City('Rivendell', 100, 'Eriador')

city.name # Rivendell
city.population # 100
city.region # Eriador
{% endhighlight %}

In the end, we have an object, `city`, with attributes defined on the fly: `name`, `population`, and `region`. All without having to create a new class!

_Note: this is not meant to be a replacement for classes, simply another option for creating objects with attributes._

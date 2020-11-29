---
layout: post
title: "Quick Tips for adding a REST API to a Rails Application"
date: 2020-05-18
landing-image: "/assets/images/posts/something.png"
comments: true
---

[![]({{ page.landing-image }}){: .bordered.landing-image.centered }]({{ page.landing-image }})

Rails projects typically start out as simple [CRUD]() operations via HTML forms and pages, but often evolve into more complex web applications. In order to add a more dynamic, client-side frontend or build a mobile application, developers usually create and integrate with a [REST]() API. 

Rails has great support for creating _new_, [API-specific applications](). However, it might be easier to _add_ a REST API to an _existing_ project (at least, maybe at first). While there is no one, "right" approach to adding an API to existing Rails application, there are some things we can do early on to make development a bit easier in the future.

## Keep API Routes in an API Namespace

In `config/routes.rb`:

{% highlight ruby %}
{% endhighlight %}

This results in the following routes:

{% highlight bash %}
{% endhighlight %}

By keeping all API routes under a specific namespace, it makes it easier for other developers to determine which URLs are API-specific. It also gives clients a consistent and descriptive URL pattern.

Another small tip is to version the API right off the bat:

{% highlight ruby %}
{% endhighlight %}

{% highlight bash %}
{% endhighlight %}

Which allows the API to grow into a `v2` in the future.

## Scope API Controllers Under an API Module

Along with a separate routing namespace, we can group all API-specific logic into their own controllers under an API module. Again, in `config/routes.rb`:

{% highlight ruby %}
{% endhighlight %}

This results in the following routes:

{% highlight bash %}
{% endhighlight %}

Then, we can create the controllers in their own folder in the project tree:

{% highlight bash %}
{% endhighlight %}

API controllers generally have to handle:

* JSON serialization
* request format handling
* API documentation (ex. `apipie` DSL)

Creating _new_ controllers, rather than adding API logic to the existing web controllers, keeps everything more cohesive.

It also allows us to write smaller, more isolated tests with less setup and more specific request formatting:

{% highlight ruby %}
{% endhighlight %}

{% highlight ruby %}
{% endhighlight %}

## Create an API-Specific Base Controller

The API controllers can probably get away with using the same "base" controller as the existing web controllers. However, it's easy _and_ beneficial to create a _separate_ base controller for the API controllers early on:

{% highlight ruby %}
{% endhighlight %}

This allows us to add API-specific request-handling for _all_ our API controllers in a single place. An example of this is `JWT` authentication.

It also keeps the API controllers from calling unused or unnecessary view-specific helper methods that might already exist, like setting a `layout` or handling `flash`.

## Share Business Logic via Service Objects

Obviously, the business logic between API and web controllers will overlap. This is where the use of common object-oriented design patterns play an important role in keeping code as DRY as possible.

Copying and pasting from controller to controller might work for smaller projects, but it's _rarely_ a good idea in larger ones. There are several different types of "service" objects that can be shared between API and view controllers:

* queries
* policies
* services (as in third-party services)

For example, querying models is something that is rarely different between the `index` actions of both API and web controllers:

{% highlight ruby %}
{% endhighlight %}

{% highlight ruby %}
{% endhighlight %}

By extracting this logic into a `Query` object, both controllers can share the same logic:

{% highlight ruby %}
{% endhighlight %}

{% highlight ruby %}
{% endhighlight %}

{% highlight ruby %}
{% endhighlight %}

This tip isn't specific controllers. In fact, using service objects this way can be beneficial throughout an _entire_ Rails codebase.

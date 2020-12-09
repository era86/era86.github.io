---
layout: post
title: "Quick Tips for adding a REST API to a Rails Application"
date: 2020-12-09
landing-image: "/assets/images/posts/api.png"
comments: true
---

[![API by Eucalyp]({{ page.landing-image }}){: .landing-image.centered }]({{ page.landing-image }})

Rails projects typically start out as simple HTML pages and forms operating on a database, but evolve into more complex applications over time. In order to add a client-side framework or mobile application, creating a [REST API](https://restfulapi.net/) might be necessary.

It's really straightforward to create a _new_ [Rails API](https://guides.rubyonrails.org/api_app.html). However, it might be easier to add an API to an _existing_ project. There is no one, "right" way to do this, but here are some things to keep in mind that can make future development a bit easier.

## Keep API Routes in an API Namespace

By keeping API routes under a specific [namespace](https://guides.rubyonrails.org/routing.html#controller-namespaces-and-routing), it's easier for other developers to find which URLs are API-specific. It also gives clients a consistent and descriptive URL pattern.

In `config/routes.rb`:

{% highlight ruby %}
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :things
    end
  end
end
{% endhighlight %}

This results in the following routes:

{% highlight bash %}
       Prefix Verb   URI Pattern                     Controller#Action
api_v1_things GET    /api/v1/things(.:format)        api/v1/things#index
              POST   /api/v1/things(.:format)        api/v1/things#create
 api_v1_thing GET    /api/v1/things/:id(.:format)    api/v1/things#show
              PATCH  /api/v1/things/:id(.:format)    api/v1/things#update
              PUT    /api/v1/things/:id(.:format)    api/v1/things#update
              DELETE /api/v1/things/:id(.:format)    api/v1/things#destroy
{% endhighlight %}

Another tip is to version the API with `v1` right off the bat, which allows it to grow into a `v2` if needed.

## Create New API Controllers Under an API Module

With the routes in a separate namespace, all API-specific logic can go into new controllers:

{% highlight ruby %}
module Api
  module V1
    class ThingsController < ApplicationController
    end
  end
end
{% endhighlight %}

They go into a similar module structure to how the routes are drawn:

{% highlight bash %}
▾ app/
  ▾ controllers/
    ▾ api/
      ▾ v1/
        things_controller.rb
{% endhighlight %}

Creating _new_ controllers, rather than adding API logic to the existing web controllers, keeps them (and their tests) smaller and more cohesive. API controllers generally have to handle:

* JSON [serialization](https://buttercms.com/blog/json-serialization-in-rails-a-complete-guide) 
* token [authentication](https://blog.restcase.com/4-most-used-rest-api-authentication-methods/)
* documentation logic (ex. [`apipie`](https://github.com/Apipie/apipie-rails#api-documentation-tool))

These are rarely needed in the existing web controllers, which handle more browser-centric concerns (ex. HTML templates).

## Use an API-Specific Base Controller

The new controllers can probably get away with inheriting from `ApplicationController`. However, it's beneficial and easy to create a _separate_ base controller:

{% highlight ruby %}
module Api
  module V1
    class BaseController < ApplicationController
    end
  end
end
{% endhighlight %}

This keeps shared, API-specific logic in its own place, like token authentication or JSON error-message formatting.

## Share Business Logic via Service Objects

Logic between API and web controllers eventually overlap. This is where design patterns can really help keep code as [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) as possible.

Service objects can be used to share logic between controllers:

* [queries](https://medium.flatstack.com/query-object-in-ruby-on-rails-56ea434365f0)
* [policies](https://github.com/varvet/pundit#policies)
* [services](https://www.toptal.com/ruby-on-rails/rails-service-objects-tutorial) (as in third-party services)

For example, querying data is typically the same in the `index` actions of both API and web controllers:

{% highlight ruby %}
class ThingsController < ApplicationController
  def index
    @things = Thing.where(user_id: current_user.id)
                   .paginate(page: params[:page], per_page: 10)
                   .order(created_at: :desc)
  end
end
{% endhighlight %}

{% highlight ruby %}
module Api
  module V1
    class ThingsController < BaseController
      @things = Thing.where(user_id: current_user.id)
                     .paginate(page: params[:page], per_page: 10)
                     .order(created_at: :desc)
      render json: @things
    end
  end
end
{% endhighlight %}

By extracting this logic into a "query" object:

{% highlight ruby %}
class ThingQuery
  def index(user:, page:)
    Thing.where(user: user.id)
         .paginate(page: page, per_page: 10)
         .order(created_at: :desc)
  end
end
{% endhighlight %}

Both controllers can share the same logic:

{% highlight ruby %}
class ThingsController < ApplicationController
  def index
    @things = ThingQuery.new.index(user: current_user, page: params[:page])
  end
end
{% endhighlight %}

{% highlight ruby %}
module Api
  module V1
    class ThingsController < BaseController
      @things = ThingQuery.new.index(user: current_user, page: params[:page])
      render json: @things
    end
  end
end
{% endhighlight %}

This tip isn't specific controllers. In fact, service objects can be beneficial throughout an _entire_ Rails codebase.

## Conclusion

Before adding a new REST API to an existing Rails project, keep these tips in mind. They aren't hard and fast rules, but they might make development easier in the future.

Questions? Comments? Critiques? Leave me a comment below!

Landing image by [Eucalyp](https://www.flaticon.com/authors/eucalyp) from [Flaticon](https://www.flaticon.com)

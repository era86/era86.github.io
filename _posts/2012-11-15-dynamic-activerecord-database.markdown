---
layout: post
title: "Dynamic ActiveRecord Database Connections (without Rails)"
date: 2012-11-15
landing-image: "/assets/images/posts/dynamic-activerecord.png"
comments: true
---

[![Dynamic ActiveRecord]({{ page.landing-image }}){: .bordered.landing-image.centered }]({{ page.landing-image }})

If you are familiar with [Ruby on Rails](http://rubyonrails.org/), you know you can configure which database to use based on the *RAILS\_ENV* environment variable. This can be one of several values: *production*, *development*, *test*, etc. You can read more about it in the [Rails Environment Settings](http://guides.rubyonrails.org/configuring.html#rails-environment-settings) section in the Ruby on Rails Guide. You can bet, somewhere in the code, Rails is doing some sort of magic with **ActiveRecord** to tell it which database connection to establish. **What if we aren't using Rails?!**

 **tl;dr** Skip blog and get [straight to the code](http://github.com/era86/dynamic_ar_connections).

## Establishing ActiveRecord Databases

Let's cover the [basics](http://api.rubyonrails.org/classes/ActiveRecord/Base.html#method-c-establish_connection).  How do we establish a basic database connection?

{% highlight ruby %}
require 'active_record'

ActiveRecord::Base.establish_connection({
  adapter:  'mysql',
  database: 'mydatabase',
  username: 'user',
  password: 'pass',
  host:     'localhost'
})
{% endhighlight %}

The code is fairly straightforward. This tells ActiveRecord to open a connection to a local MySQL database named *mydatabase* and use *user* and *pass* as the login credentials. Now, we can do cool things with our database like create tables and populate them with stuff using models:

{% highlight ruby %}
ActiveRecord::Schema.define do
  create_table :dogs do |t|
    t.integer :id, :null => false
    t.string  :name
    t.date    :dob
  end
end

class Dog < ActiveRecord::Base
end

Dog.create({
  id:   0,
  name: 'Scruffy',
  dob:  '2012-01-01'
})
{% endhighlight %}

## Choose a Configuration using Environment Variables

Let's recreate the "magic" in Rails by reading in an environment variable to decide which database connection to open. We do this by using `ENV`:

{% highlight ruby %}
require 'active_record'

conf = case ENV['DB']
when 'conf1'
  {
    adapter: 'sqlite3',
    database: 'db/mydb1.sqlite3'
  }
when 'conf2'
  {
    adapter: 'sqlite3',
    database: 'db/mydb2.sqlite3'
  }
else
  raise 'export DB=conf[n]'
end

ActiveRecord::Base.establish_connection conf
{% endhighlight %}

Before we run this script, we need to set our environment variable:

{% highlight bash %}
export DB=conf1 # or conf2
{% endhighlight %}

Now, depending on `ENV['DB']`, the code will open a connection to either *mydb1.sqlite3* or *mydb2.sqlite3*.

## Externalize Database Configurations

**Never store the database configurations in your code.** If you distribute the code, all of the information will be available for people to see! This may or may not be a security issue in your situation, but it's better to play it safe and store database configurations somewhere else. Let's call our database configuration file *database.yml* (looks familiar):

{% highlight yaml %}
conf1:
  adapter: sqlite3
  database: db/mydb1.sqlite3

conf2:
  adapter:  sqlite3
  database: db/mydb2.sqlite3
{% endhighlight %}

Let's tell ActiveRecord to establish a connection to the proper database by loading our YAML file:

{% highlight ruby %}
require 'active_record'

conf = YAML.load_file('database.yml')

ActiveRecord::Base.establish_connection conf[ENV['DB']]
{% endhighlight %}

Success! We can set our environment variable the same way as before, but our code will look in a YAML file for the proper database configuration rather than some hashes in code.

---
layout: post
title: Dynamic ActiveRecord Database Connections (without Rails)
date: '2012-11-15T11:00:00.000-08:00'
author: Frederick Ancheta
tags:
- ruby
- dynamic
- configuration
- connection
- yaml
- activerecord
- establish_connection
- env
- database.yml
modified_time: '2012-11-15T11:00:41.726-08:00'
thumbnail: http://1.bp.blogspot.com/-MNZdaPLDKwo/UKSnFVG5C8I/AAAAAAAAASo/0G5mP5mRtWQ/s72-c/ActiveRecord.png
blogger_id: tag:blogger.com,1999:blog-9008563869490582540.post-5314220184950632844
blogger_orig_url: http://www.runtime-era.com/2012/11/dynamic-activerecord-database.html
---

[![](http://1.bp.blogspot.com/-MNZdaPLDKwo/UKSnFVG5C8I/AAAAAAAAASo/0G5mP5mRtWQ/s400/ActiveRecord.png)](http://1.bp.blogspot.com/-MNZdaPLDKwo/UKSnFVG5C8I/AAAAAAAAASo/0G5mP5mRtWQ/s1600/ActiveRecord.png)

If you are familiar with [Ruby on Rails](http://rubyonrails.org/), you
know you can configure which database to use based on the *RAILS\_ENV*
environment variable. This can be one of several values: *production*,
*development*, *test*, etc. You can read more about it in the [Rails
Environment
Settings](http://guides.rubyonrails.org/configuring.html#rails-environment-settings)
section in the Ruby on Rails Guide. You can bet, somewhere in the code,
Rails is doing some sort of magic with **ActiveRecord** to tell it which
database connection to establish. **What if we aren't using Rails?!**\
\
 **tl;dr** Skip blog and get [straight to the
code](http://github.com/era86/dynamic_ar_connections). \
\

### Establishing ActiveRecord Databases

Let's cover the
[basics](http://api.rubyonrails.org/classes/ActiveRecord/Base.html#method-c-establish_connection).
How do we establish a basic database connection?

~~~~ {.brush: .ruby}
require 'active_record'ActiveRecord::Base.establish_connection({  adapter:  'mysql',  database: 'mydatabase',  username: 'user',  password: 'pass',  host:     'localhost'})
~~~~

The code is fairly straightforward. This tells ActiveRecord to open a
connection to a local MySQL database named *mydatabase* and use *user*
and *pass* as the login credentials. Now, we can do cool things with our
database like create tables and populate them with stuff using models:

~~~~ {.brush: .ruby}
ActiveRecord::Schema.define do  create_table :dogs do |t|    t.integer :id, :null => false    t.string  :name    t.date    :dob  endendclass Dog < ActiveRecord::BaseendDog.create({  id:   0,  name: 'Scruffy',  dob:  '2012-01-01'})
~~~~

### Choose a Configuration using Environment Variables

Let's recreate the "magic" in Rails by reading in an environment
variable to decide which database connection to open. We do this by
using **ENV**:

~~~~ {.brush: .ruby}
require 'active_record'conf = case ENV['DB']when 'conf1'  {    adapter:  'sqlite3',    database: 'db/mydb1.sqlite3'  }when 'conf2'  {    adapter:  'sqlite3',    database: 'db/mydb2.sqlite3'  }else  raise 'export DB=conf[n]'endActiveRecord::Base.establish_connection conf
~~~~

Before we run this script, we need to set our environment variable:

~~~~ {.brush: .bash}
export DB=conf1 # or conf2
~~~~

Now, depending on *ENV['DB']*, the code will open a connection to either
*mydb1.sqlite3* or *mydb2.sqlite3*. \
\

### Externalize Database Configurations

**Never store the database configurations in your code.** If you
distribute the code, all of the information will be available for people
to see! This may or may not be a security issue in your situation, but
it's better to play it safe and store database configurations somewhere
else. Let's call our database configuration file *database.yml* (looks
familiar):

~~~~ {.brush: .ruby}
conf1:  adapter:  sqlite3  database: db/mydb1.sqlite3conf2:  adapter:  sqlite3  database: db/mydb2.sqlite3
~~~~

Let's tell ActiveRecord to establish a connection to the proper database
by loading our YAML file:

~~~~ {.brush: .ruby}
require 'active_record'conf = YAML.load_file('database.yml')ActiveRecord::Base.establish_connection conf[ENV['DB']]
~~~~

Success! We can set our environment variable the same way as before, but
our code will look in a YAML file for the proper database configuration
rather than some hashes in code. \
\


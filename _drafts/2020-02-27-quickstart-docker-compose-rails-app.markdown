---
layout: post
title:  "Rails Development Environment with Docker Compose in Ubuntu 18.04"
date:   2020-02-27
landing-image: "/assets/images/posts/pair.jpg"
comments: true
---

[![Pair Programming]({{ page.landing-image }}){: .bordered.landing-image.centered }]({{ page.landing-image }})

### Install Docker

We can install the default version of Docker from the Ubuntu repo:

{% highlight bash %}
sudo apt-get install -y docker.io
{% endhighlight %}

Alternatively, we can install the latest Docker engine by following [these instructions](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04).

### Allow current user to run Docker commands

On Ubuntu, the `docker` command can only be run by `root`. To avoid having to type `sudo docker` all the time, add the current user to the `docker` group:

{% highlight bash %}
sudo usermod -aG docker ${USER}
{% endhighlight %}

### Install Docker Compose

We can install the default version of Docker Compose from the Ubuntu repo:

{% highlight bash %}
sudo apt-get install -y docker-compose
{% endhighlight %}

Alternatively, we can install the latest Docker Compose by following [these instructions](https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-ubuntu-18-04).

After installing Docker and Docker Compose, it's best to restart the system.

### Create root folder for the project

This is the root folder of the project:

{% highlight bash %}
mkdir project/
{% endhighlight %}

### Create Rails application folder within project

We create a new folder for our Rails application _within_ `project`:

{% highlight bash %}
mkdir project/web/
{% endhighlight %}

The Rails application is in its own folder to keep the `project` folder framework-agnostic, in case there are other applications we want to add in the future.

### Create Dockerfile

Within `project/web/`, create a file named `Dockerfile`:

{% highlight docker %}
FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential nodejs

RUN mkdir /app
WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app
{% endhighlight %}

This tells Docker how to build the container. For a deeper dive on `Dockerfile`, see the [offical reference](https://docs.docker.com/v17.09/engine/reference/builder/).

### Create initial Gemfile and Gemfile.lock

Within `project/web/`, create a file named `Gemfile`:

{% highlight ruby %}
source 'https://rubygems.org'
gem 'rails', '~> 6'
{% endhighlight %}

This file _initially_ tells the container to install Rails using a tool called [Bundler](https://bundler.io/). Eventually, it will be overwritten. In addition to the `Gemfile`, an empty file named `Gemfile.lock` must be created:

{% highlight bash %}
touch Gemfile.lock
{% endhighlight %}

For a deeper dive on `Gemfile` and `Gemfile.lock`, see the [official reference](https://bundler.io/gemfile.html).

### Create docker-compose.yml

Within `project/`, create a file named `docker-compose.yml`:

{% highlight yaml %}
version: '3'
services:
  web:
    build: ./web
    command: bundle exec puma -C config/puma.rb
    volumes:
      - ./web:/app
    ports:
      - "3000:3000"
{% endhighlight %}

This YAML file tells Docker Compose how to build our containers. Currently, there's only one: `web`. However, we can add more in the future by creating entries in this file (ex. PostgreSQL container, React frontend container).

For a deeper dive on `docker-compose.yml`, see the [official reference](https://docs.docker.com/compose/compose-file/).

### Create new Rails application by running commands within the container

With all the proper files in place, create a new Rails application within the `web` folder via `docker-compose`:

{% highlight bash %}
docker-compose run web bundle exec rails new . --force
{% endhighlight %}

This builds the container defined in `docker-compose.yml` and runs `bundle exec rails new . --force` within it, creating a new Rails application in the `web` directory.

_Note: this overwrites the existing `Gemfile` with the necessary dependencies for Rails._

### Reinstall Rails-specific Gems within the container

Since the original `Gemfile` was overwritten, the container needs to install the new gems. This can be done by rebuilding the `web` container:

{% highlight bash %}
docker-compose up -d --no-deps --build web
{% endhighlight %}

### Change ownership of Rails project files to current user

Because containers are run as `root` in Ubuntu, the files created by `rails new` are _owned_ by `root`. To allow local editing of the Rails application files, change the owner of the files to the current user:

{% highlight bash %}
sudo chown -R $USER:$USER .
{% endhighlight %}

### Run the local Rails development server

Finally, start the container:

{% highlight bash %}
docker-compose up
{% endhighlight %}

And visit [`http://localhost:3000`](http://localhost:3000). The default Rails homepage should show up:

[![](/assets/images/posts/blogger-post-editor.png){: .bordered }](/assets/images/posts/blogger-post-editor.png)

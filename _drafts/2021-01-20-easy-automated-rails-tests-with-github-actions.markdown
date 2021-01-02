---
layout: post
title: "Easy Automated Rails Tests with Github Actions"
date: 2021-01-20
landing-image: "/assets/images/posts/github-actions.png"
comments: true
---

[![Github Actions]({{ page.landing-image }}){: .bordered.landing-image.centered }]({{ page.landing-image }})

Modern software development typically includes some form of [continuous integration and delivery](https://www.thoughtworks.com/continuous-integration). As such, engineering teams have to detect regressions _quickly_, as new code continuously gets merged into the build. An essential part of regression detection is **automated tests**.

## What are automated tests?

As the name implies, automated tests are **tests that run _automatically_ without manual supervision**.

## What are Github Actions?

[Github Actions](https://docs.github.com/en/free-pro-team@latest/actions/learn-github-actions/introduction-to-github-actions) enable engineering teams to automate specific parts of the software developement workflow within Github. This includes building, testing, or deploying code. For projects stored on Github, **creating a workflow via Github Actions is a _quick and easy_ way to do automated testing**.

Github Actions can be added to any project by creating YAML files in `.github/workflows/`, at the root of the project repository. [Workflows](https://docs.github.com/en/free-pro-team@latest/actions/reference/workflow-syntax-for-github-actions) have a simple, hierarchical structure made up of **events**, **jobs**, and **steps**. For a more in-depth overview, see the [official tutorial](https://docs.github.com/en/free-pro-team@latest/actions/learn-github-actions).

## A Basic Workflow for Automated Tests in Rails 6

This is a "starter" workflow for automatically running tests for a Rails 6 project on Github. It does the following:

1. [Triggers the workflow](https://docs.github.com/en/free-pro-team@latest/actions/reference/events-that-trigger-workflows) when code is pushed _or_ a pull request is created
2. Connects a [PostgreSQL service container](https://docs.github.com/en/free-pro-team@latest/actions/guides/creating-postgresql-service-containers)
3. Pulls in the relevant branch using the [`checkout` community action](https://github.com/marketplace/actions/checkout)
4. Installs Ruby `2.7.x`
5. Installs project dependencies in `Gemfile` via `bundler`
6. Preps the database and runs the tests

{% highlight ruby %}
name: Test
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    services:
      db:
        image: postgres
        env:
          POSTGRES_USER: postgres
          POSTGRES_PASSWORD: postgres
          POSTGRES_DB: postgres
        ports: ['5432:5432']
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
    steps:
      - uses: actions/checkout@v1
      - name: Setup Ruby
        uses: actions/setup-ruby@v1
        with:
          ruby-version: 2.7.x
      - name: Build and run tests
        env:
          PGHOST: localhost
          PGUSER: postgres
          PGPASSWORD: postgres
          DATABASE_URL: postgres://postgres:@localhost:5432/test
          RAILS_ENV: test
          RAILS_MASTER_KEY: ${{ secrets.RAILS_MASTER_KEY }}
        run: |
          sudo apt-get -yqq install libpq-dev
          gem install bundler
          bundle install --jobs 4 --retry 3
          yarn install
          bundle exec rails db:prepare
          bundle exec rails test
{% endhighlight %}

Most of the workflow configuration file is self-explanatory, but the official documentation does a great job of [breaking down the fundamental parts](https://docs.github.com/en/free-pro-team@latest/actions/learn-github-actions/introduction-to-github-actions#understanding-the-workflow-file). It's worth a quick read!

Happy testing!

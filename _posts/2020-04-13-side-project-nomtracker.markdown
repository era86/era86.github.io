---
layout: post
title: "Side Project: NomTracker"
date: 2020-04-13
landing-image: "/assets/images/posts/nom-shot.png"
comments: true
---

[![NomTracker]({{ page.landing-image }}){: .landing-image.centered }](https://nomtracker.herokuapp.com/)

It's been awhile since I started and actually _deployed_ a side project! Meet, [NomTracker](https://nomtracker.herokuapp.com/), a stripped-down clone of [MyFitnessPal](https://www.myfitnesspal.com/). For the past two weeks, this has occupied some of my free time (of which I have more of nowadays). It was fun to learn and relearn all of the steps required to go from nothing to website, a much-needed refresher!

## Why a side project?

Unfortunately, my company had to let me go (thanks a lot, COVID). It was a huge blow to my confidence as a web developer and the imposter syndrome completely took over. While I enjoy practicing my [LeetCode](https://leetcode.com/) tech interview puzzles (ugh), I wanted to prove to myself I still had the ability to plan, implement, and deploy something on the web.

## Why a calorie tracker?

As a believer in [IIFYM](https://www.iifym.com/), the only nutrients I ever need to track are calories, carbs, protein, and fat. I rarely care about micronutrients. While MyFitnessPal allows me to track calories and macros, the website feels like a heavy, clunky tool for doing so (the mobile app is much better). I wanted a stripped-down version of MyFitnessPal, so I made one.

## The Tech Stack

All of my local development was done in [Docker](https://www.docker.com/) and Docker Compose. I basically started everything off using [this setup]({% post_url 2020-02-26-rails-development-environment-with-docker-compose-ubuntu-1804 %}), with Rails and PostgreSQL in separate containers. My _initial_ plan was to build the REST API and the React frontend in separate containers, but I scrapped the idea for a monolith to keep things dead simple.

### Ruby on Rails 6

<img style="height: 150px;" align="left" src="/assets/images/posts/ruby-on-rails.png">

It's the framework I'm most productive in and the language I'm most familiar with. There's no place like home! After working in [Django](https://www.djangoproject.com/) for a little under two years, going back to [Rails](https://rubyonrails.org/) was a breath of fresh air. All of the pages _and_ the REST API are built in the monolith. [Devise](https://github.com/heartcombo/devise) drives user authentication, [Fast JSON API](https://github.com/Netflix/fast_jsonapi) is used for API serialization, and [ActiveAdmin](https://github.com/activeadmin/activeadmin) is used for... admin.

### React + No Redux

<img style="height: 150px;" align="left" src="/assets/images/posts/react-logo.png">

At my last job, I was _finally_ able to work on some [React](https://reactjs.org/)! While my skills are hella basic, it felt good to build dynamic and interactive components from scratch. It also felt good to struggle with prop drilling, deep callback currying, and confusing props vs state. I very likely should introduce Redux, but my God-tier, top-level, state-holding component will do for now.

### Bulma CSS

<img style="height: 150px;" align="left" src="/assets/images/posts/bulma-logo.png">

Initially, I wanted to do _all_ of the CSS myself, using [Sass](https://sass-lang.com/) for the Rails pages and [styled-components](https://styled-components.com/) for the React components. Turns out, I don't like spending time `flexbox`-ing and `@media`-ing myself to death. In the end, I Googled "minimalist CSS frameworks, not Bootstrap", found [this awesome list](https://github.com/troxler/awesome-css-frameworks), and chose [Bulma](https://bulma.io/) because I like Dragon Ball Z.
<br />
<br />

### USDA FoodData

<img style="height: 150px;" align="left" src="/assets/images/posts/usda.png">

Turns out, food and nutrition data is [_expensive_](https://www.nutritionix.com/business/api). However, the USDA has [500MB worth of CSVs](https://fdc.nal.usda.gov/download-datasets.html) with 70-million rows of foods along with their nutrition facts! To leverage this data, I spent time writing scripts to extract, transform, and load this data into NomTracker's data model. It was a fun challenge, leveraging Ruby [threads](https://github.com/meh/ruby-thread)! The food database in NomTracker isn't quite where MyFitnessPal's is, but it's a start.

### Heroku

<img style="height: 150px;" align="left" src="/assets/images/posts/heroku.png">

For small side projects like this, [Heroku](https://www.heroku.com/) is my go-to deployment platform! The [tutorials in their Dev Center](https://devcenter.heroku.com/articles/getting-started-with-rails6) make the deployment process super easy. It's also really easy to add and configure tools like PostgreSQL and [SendGrid](https://sendgrid.com/), which interact with Rails. While it'd be "cool" to orchestrate containers for each of these services in [Amazon ECS](https://aws.amazon.com/ecs/), I opted to be "boring" here.

## Conclusion

While it's not the sexiest project out there, NomTracker is a small confidence boost for a web developer like me. It definitely helps me feel like less of an imposter.

Questions? Critiques? Leave me a comment below!

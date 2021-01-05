---
layout: post
title: "Treat New Engineers to a Day-One Production Deploy"
date: 2021-01-05
landing-image: "/assets/images/posts/rocket-launch.png"
comments: true
---

[![Rocket Launch]({{ page.landing-image }}){: .landing-image.centered }]({{ page.landing-image }})

Every engineering team has an onboarding process for new hires. The main goals are to get set up and contribute as soon as possible. There are [many different ways](https://www.pluralsight.com/blog/teams/onboarding-engineers-competitive-advantage) to achieve these goals, but one thing I've found incredibly helpful in speeding things up is a "Day-One Deploy".

## What is a Day-One Deploy?

A Day-One Deploy is self-explanatory: **on the very first day, a new hire writes code and deploys it to production**.

## Why is it awesome?

### It forces the team to make development environment setup quick and easy

Deploying to production in a day is a feat for _any_ engineer. For a new hire, there's the added bonus of setting up the local development environment. Using tools like [Docker](https://www.docker.com) or [Vagrant](https://www.vagrantup.com) to automate building the tech stack can really expedite this step, along with well-written and _concise_ documentation. Not only do these help a new hire get set up quickly, it improves the engineering efficiency of the whole team.

### It's a speed-run of the day-to-day life on the job

By taking a new hire through the _entire_ process, from pulling a ticket to production verification, it gives insight into the day-to-day life as an engineer on the team. All necessary tools are introduced: version control, code review, continuous integration, etc. It's an opportunity for an engineer to get a high-level overview of all the necessary steps for getting things done.

### It's a fun way to introduce a new member of the team

After code is successfully deployed to production, it's a great opportunity to shout it out in Slack and let the entire team know! It could even serve as an introduction of the new team member to the _company_. Not only is a day-one deploy a huge confidence boost to the new engineer, it's a great morale booster for the team. A celebration of things to come!

## Tips for an Awesome Day-One Deploy

### Keep the task is small, but impactful

Ideally, the task for a day-one deploy is small in scope and lower in priority. The code itself isn't the star of the show, the _development process_ is. That said, the task should have noticeable impact, even if it's small. For example, a copy-edit on the "About Us" page for the company is relatively small, but reaches a wide audience.

### Pair up and provide guidance

_Never_, during any part of the day-one deploy, should a new engineer be left to flounder. A senior member of the team should be a designated guide for the new hire all the way to the end. Frequent check-ins might be enough, but pairing up the whole day is an even better option. Either way, the team needs to devote the time and energy to see the new hire all the way through.

### Don't go too in-depth

It takes more than a day to learn the ins and outs of an engineering team. The tools, the people, the processes. All of it takes time. Rather than dive too deeply into one particular detail, keep it shallow. A day-one deploy is a bird's eye view. Encourage the new hire to ask questions, but defer any long-winded explanations until _after_ production is deployed.

Got any other tips or tricks for success day-one deploys? Let me know in the comments!

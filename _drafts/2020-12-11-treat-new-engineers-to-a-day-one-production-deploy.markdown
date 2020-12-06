---
layout: post
title: "Treat New Engineers to a Day-One Production Deploy"
date: 2020-12-11
landing-image: "/assets/images/posts/something.png"
comments: true
---

[![]({{ page.landing-image }}){: .bordered.landing-image.centered }]({{ page.landing-image }})

Every great engineering team has a process for onboarding new team members. The goal is to get the new hire set up and productive as soon as possible.

A few years ago, I was brought onto a team who, in addition to having all the typical onboarding steps, included a "Day-One Deploy". This was something I had never done and it was an incredibly quick way to learn and contribute right away!

## What is a Day-One Deploy?

A Day-One Deploy is exactly as described: the very first day an engineer starts a new job, he or she writes some code, pushes it, and deploys it to production.

## Why is it awesome?

### It forces the team to make development environment setup quick and easy

Deploying to production in a day is a feat for _any_ engineer. For a _new_ engineer, there's the added bonus of setting up the local development environment. For a day-one deploy to work, this step _needs_ to be as quick and efficient as possible. This means leveraging tools like Docker or Vagrant to build and start run the tech stack without having manually install and manage dependencies. It also means any onboarding documentation has to be up-to-date, straightforward, and _concise_.

### It gives a new engineer the chance to contribute right away

New hires are often eager to prove themselves. A day-one deploy is a great chance for an engineer to contribute right away and show how he or she will help the team. It is also a great way for a team to evaluate and determine the proper amount of guidance to provide moving forward.

### It's a speed-run of the day-to-day life on the job



* everything in between creating pulling a ticket and verifying in production is exposed
* while light on the details, the new engineer will have a high-level idea of what life will be like working on the team
* basically all the tools the team uses will be introduced: version control, code review, testing/integration, etc.
* the engineer can take notes on those tools, then go back and fill in any gaps in knowledge afterwards

### It's a fun way to introduce and welcome a new member of the team

* when the code is successfully deployed to production, it's a great opportunity to shout it out in Slack and let the entire team know
* this can also serve as an introduction of the new team member to the company as a whole
* it's a confidence and morale booster, a mini celebration of things to come

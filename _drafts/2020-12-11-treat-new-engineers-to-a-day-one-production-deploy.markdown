---
layout: post
title: "Treat New Engineers to a Day-One Production Deploy"
date: 2020-12-11
landing-image: "/assets/images/posts/rocket-launch.png"
comments: true
---

[![Rocket Launch]({{ page.landing-image }}){: .landing-image.centered }]({{ page.landing-image }})

Every engineering team has an onboarding process for new hires. The main goals are getting set up and productive as soon as possible. There are many different ways to achieve these goals, but one thing I've found incredibly helpful in speeding things up is a "Day-One Deploy".

## What is a Day-One Deploy?

A Day-One Deploy is self-explanatory: **on the very first day, a new hire writes code and deploys it to production**.

## Why is it awesome?

### It forces the team to make development environment setup quick and easy

Deploying to production in a day is a feat for _any_ engineer. For a new hire, there's the added bonus of setting up the local development environment. Using tools like [Docker]() or [Vagrant]() to automate building the tech stack can really expedite this step. It's also important to keep onboarding documentation up-to-date, straight-forward, and _concise_. Not only does this help a new hire get set up quickly, it might improve engineering efficiency overall.

### It gives a new hire the chance to contribute right away

New hires are often eager to prove themselves. 

### It's a speed-run of the day-to-day life on the job

By taking a new hire through the _entire_ process, from pulling a ticket to production verification, it gives insight into the day-to-day life as an engineer on the team. All necessary tools are introduced: version control, code review, continuous integration etc. It's an opportunity for an engineer to get a high-level overview of all the necessary steps for getting things done.

### It's a fun way to introduce and welcome a new member of the team

After code is successfully deployed to production, it's a great opportunity to shout it out in Slack and let the entire team know! It could even serve as an introduction of the new team member to the _company_. Not only is a day-one deploy a huge confidence boost to the new engineer, it's a great morale booster for the team. A celebration of things to come!

## Tips for an Awesome Day-One Deploy

### Keep the Task is Small, but Impactful

Ideally, the task for a day-one deploy is small in scope and lower in priority. The code itself isn't the star of the show, the _development process_ is. That said, the impact of the task should be noticeable, even if it's small. An example of this might be a copy edit to the "About Us" page for the company.

### Pair Up and Provide Guidance

Never, during any step of the day-one deploy process, should a new engineer be left to flounder. A senior member of the team should be a designated guide for the new hire all the way to the end. Pairing up the whole day is an option, but more frequent check-ins might be enough. Either way, the team needs to devote the time and energy to see it all the way through.

### Don't Go Too In-Depth

It takes more than a day to learn the ins and outs of an engineering team. The tools, the people, the operations. All of it takes time. Rather than dive too deeply into one particular step of the process, keep it shallow. A day-one deploy is a bird's eye view. Encourage the new hire to ask questions, but defer any long-winded explanations until _after_ production is deployed.

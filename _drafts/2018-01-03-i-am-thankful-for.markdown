---
layout: post
title: '"I Am Thankful For…" An Appreciation for 2017'
date: 2018-01-03
comments: true
---

The beginning of a new year is a great time to look back and reflect on everything we're grateful for. As a web developer, I like to take a look at the tools that have made impacts on my work or side projects. So, here are some of the developer-related gifts I'm thankful for this year.


## Vagrant

Setting up a local machine is easy enough to do for any web developer. You install stack dependencies, an IDE or text-editor, and a web browser. Voila! You're ready to work. Then, someone else joins your team or you get a brand new laptop. Suddenly, you have to spend hours trying to remember or sifting through outdated documentation to get everything set up properly.

Vagrant can be used to help speed up this process. It uses virtualization to create and provision self-contained virtual machines for any type of development environment. The configuration instructions for setting up a new development environment is stored in a Vagrantfile. This Vagrantfile can be saved or shared amongst developers to create copies of development environments on any machine that has Vagrant installed. 

This makes it easy to create, destroy, and modify development environments and share them with others.

## Jenkins

While I primarily work in web development, I was able to work more closely with my development team to help improve the overall development process. This includes improvements to automated testing and deployment. I've worked on teams who had neither, and it was a complete nightmare to get anything done with any confidence that it actually works.

Jenkins makes automation easy, but has enough flexibility to create different pipelines and processes. It also has lots of community support, with several different plugins for integration with third-party tools.

In my case, I was able to create Jenkins jobs that poll a Mercurial repository for new commits, run a suite of tests, deploy code to a staging environment, and send a Slack message to the authors. This way, developers can simply push their code and get notified when their changes are ready to verify (assuming everything else in between succeeds).

## Heroku

Most of my side projects involve learning new technology stacks or experimenting with different programming languages. Rarely do I share these with the world. However, for quick and light hosting, Heroku is my weapon of choice.

If you know how to push commits to Github, you know how to deploy to Heroku. Heroku has a suite of command-line tools to manage everything from deployment to database migrations. Since it's a relatively popular service, there are tons of tutorials out on the web for deploying many different types of projects.



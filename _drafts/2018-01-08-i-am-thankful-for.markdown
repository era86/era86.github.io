---
layout: post
title: '"I Am Thankful For…" An Appreciation for 2017'
date: 2018-01-08
comments: true
---

The beginning of a new year is a great time to look back and reflect on everything we're grateful for. As a web developer, I like to take a look at the tools that have made impacts on my work or side projects. Here are a few of the developer-related gifts I'm thankful for this year.

## Vagrant

[<img style="height: 250px; border: solid 1px #CCC;" align="left" src="/assets/images/posts/vagrant.png">](https://www.vagrantup.com/)

Setting up a local machine is easy enough to do for any web developer. You install stack dependencies, an IDE or text-editor, and a web browser. Voila! You're ready to work. Then, someone else joins your team or you get a brand new computer. Suddenly, you have to spend time re-installing everything from memory or from outdated documentation.

[Vagrant](https://www.vagrantup.com/) can help speed up this process. It uses virtualization to create and set up virtual machines for any type of development environment. The configuration instructions for provisioning a new machine is stored in a `Vagrantfile`. The `Vagrantfile` can be stored or shared with other developers to create identical development environments on any computer with Vagrant installed. 

This makes it easy to create self-containted development environments and replicate on other computers with ease!

## Jenkins

[<img style="height: 250px; border: solid 1px #CCC;" align="left" src="/assets/images/posts/jenkins.png">](https://jenkins-ci.org/)

Most of my time at work is spent in web stacks. However, I recently spent a bit of time looking at ways to improve our development process. This allowed me to dive into a whole new world of automated testing and deployment. 

[Continuous integration](https://www.thoughtworks.com/continuous-integration) is nothing new, but it was my first time working on the tools to make it all happen. My goal was to poll our code repository for new commits, run a suite of tests, deploy the changes to a staging environment upon success, and send a chat message to the authors.

[Jenkins](https://jenkins-ci.org/) makes this type of automation really simple. Developers can create several different jobs, schedule them, and keep a backlog of the builds. The UI makes defining build-steps simple, but pipelines can be more customized with Groovy scripts. Jenkins also has great community support, with many plugins available for integrating with third-party tools and services.

## Heroku

[<img style="height: 250px; border: solid 1px #CCC;" align="left" src="/assets/images/posts/heroku.png">](https://www.heroku.com)

My side projects usually involve exploring new technology stacks or experimenting with other programming languages. Rarely do I share any of them with the world. However, for quick and light web hosting, [Heroku](https://www.heroku.com/) is my platform of choice.

If you know how to push commits to [Github](https://github.com/), you know how to deploy to Heroku. It has a suite of command-line tools for managing everything from deployment to one-off Bash commands. It also provides a nice UI for viewing logs, anaylzing metrics, and configuring environments.

Admittedly, I've never had to scale any of my projects, but for me, Heroku provides _just_ enough for my needs!

# Conclusion

Many, many thanks to the creators and maintainers of these tools! Without them, my life as a web developer would be more difficult.

What are you thankful for this year? Let me know in the comments!

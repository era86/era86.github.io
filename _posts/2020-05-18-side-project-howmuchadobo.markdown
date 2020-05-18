---
layout: post
title: "Side Project: How Much Adobo?"
date: 2020-05-18
landing-image: "/assets/images/posts/howmuchadobo-logo.png"
comments: true
---

[![How Much Adobo?]({{ page.landing-image }}){: .bordered.landing-image.centered }](https://www.howmuchadobo.com)

Spent more time working on another random project this month! Meet [How Much Adobo?](https://www.howmuchadobo.com), an online meal-generator that tells you how much chicken adobo and rice you should eat to meet your calorie goals! Sure, it's esoteric, but it was a fun way to work with some new technologies I haven't had the pleasure of working with.

## Why a TDEE calculator?

In my experience, weight management (for most people) is as simple as calories in, calories out. The magic number typically used for calorie targeting is known as [TDEE](https://chomps.com/blogs/news/what-is-bmr-tdee), the estimate of calories burned per day. There are already [TDEE calculators](https://tdeecalculator.net/) out there, but in my opinion, there is no reason this couldn't be a single-page, mobile-friendly web application. So, I built it.

## Why Filipino chicken adobo and rice?

While TDEE is useful, it's more _fun_ to think of calorie goals in terms of real, actual food. I chose to express it as [chicken adobo](https://www.tasteofhome.com/recipes/filipino-chicken-adobo/) and rice. While it seems arbitrary, it's literally the _best_ food on the planet! Alright, it's arbitrary, but it's my favorite food.

## The Tech Stack

### Next.js

<img style="height: 150px;" align="left" src="/assets/images/posts/nextjs.png">

For a small calculator-esque application, there really is no need for a full web stack. Really, it's HTML, CSS, and some JavaScript. Even a static site generator could be considered overkill! That said, I wanted to build everything using React, but have the page be rendered server-side, providing a static-HTML-page experience. [Next.js](https://nextjs.org/) fit the bill perfectly. It allowed me to build my entire application in React and comes with server-side rendering built in.

### Skeleton CSS

<img style="height: 150px;" align="left" src="/assets/images/posts/skeleton-pens.png">

A calculator doesn't require much style. There are tons of fully-featured UI frameworks out there, but [Skeleton CSS](http://getskeleton.com/) strikes the best balance between lightweight and feature-rich. In fact, it's described as "a starting point, not a UI framework", which was perfect for my project. I just needed the page to not be ugly on mobile and Skeleton CSS did the trick.

<br/>
### Total Daily Energy Expenditure (TDEE) Formulas

<img style="height: 150px;" align="left" src="/assets/images/posts/tdee.png">

As stated before, TDEE is an estimate of calories a person burns each day. It is found by taking a person's Basal Metabolic Rate (BMR) and applying a multiplier based on daily activity. There are many different ways to calculate this magic number, but the most [popular formulas](https://en.wikipedia.org/wiki/Basal_metabolic_rate) are *Mifflin-St Jeor* for BMR and *Katch-Mcardle* for activity multipliers. So, I used both in this project.

### Vercel

<img style="height: 150px;" align="left" src="/assets/images/posts/vercel.png">

At first, I deployed my application to [Heroku](https://www.heroku.com/). However, I ran into issues configuring [SSL](https://devcenter.heroku.com/articles/ssl) with a custom domain. Automatic certificate management is _not_ free in Heroku, and I'm cheap. I didn't want to pay. Instead, I went with [Vercel](https://vercel.com/), a frontend-focused hosting platform. It was _so_ easy to configure a custom domain (with SSL management!) _and_ it has automatic Git integration for deployments by default. In no time, I was up and running!

## Conclusion

Again, it's not the sexiest project out there, but it was really fun to work on! Now, excuse me while I eat 2200 calories of chicken adobo and rice! Cheers!

Questions? Critiques? Leave me a comment below!

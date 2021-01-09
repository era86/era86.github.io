---
layout: post
title: "Free SSL with Heroku, Cloudflare, and Google Domains"
date: 2021-02-17
landing-image: "/assets/images/posts/something.png"
comments: true
---

[![]({{ page.landing-image }}){: .bordered.landing-image.centered }]({{ page.landing-image }})

Recently, I went through the process of deploying a small Rails application on Heroku and registering a custom domain with Google Domains for it. In today's web, [HTTPS encryption]() is a _must have_, and I wanted it for my new site. Rather than pay for [Heroku's Automated Certificate Management](https://devcenter.heroku.com/articles/automated-certificate-management), I decided to use [Cloudflare's Free SSL/TLS protection](https://www.cloudflare.com/ssl/) and configure Heroku myself.

These are the steps I took to configure Heroku and Google Domains to get free SSL through Cloudflare!

## Add Custom Domains to Heroku App Settings

Log into Heroku and go to `Settings` -> `Domains` for your Heroku application. Add two custom domains:

[![](/assets/images/posts/ssl-step-0-heroku-custom-domains.png){: .bordered }](/assets/images/posts/ssl-step-0-heroku-custom-domains.png)

1. **Domain name:** `"another-cool-domain.com"`
2. **Domain name:** `"www.another-cool-domain.com"`

For each of the new custom domains, a **DNS Target** is created. Take note of them because they will be used in Cloudflare.

## Add Heroku DNS Entries to Cloudflare Domain

Log into Cloudflare and manage an existing domain (or [create a new managed domain]()). Go to the `DNS` settings dashboard to the section named **DNS management for another-cool-domain.com**. In here, add two new DNS records:

Type: `"CNAME"`
Name: `"another-cool-domain.com"`
IPv4 Address: [`DNS Target` for `"another-cool-domain.com"` in Heroku]
TTL: `"Auto"`

Type: `"CNAME"`
Name: `"www"`
IPv4 Address: [`DNS Target` for `"www.another-cool-domain.com"` in Heroku]
TTL: `"Auto"`

## Set Cloudflare Nameservers in Google Domains

In Cloudflare, below the DNS records, there is a section named `Cloudflare nameservers`:

These are the nameservers that need to be set in Google Domains.

Log into Google Domains and click `Manage` for your domain (or [buy a new domain]()). In the menu, click `DNS`. In the section named `Name servers`, select `Use custom name servers` and add two new entries for each of the nameservers from Cloudflare:

## Set Up Cloudflare's SSL Settings

Back in Cloudflare, go to `SSL/TLS` -> `Overview`. Select `Flexible` for the encryption mode:

Now, go to `Edge Certificates` and flip the switch for `Always Use HTTPS` to `On`.

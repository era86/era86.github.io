---
layout: post
title: "Free SSL with Heroku, Cloudflare, and Google Domains"
date: 2021-02-17
landing-image: "/assets/images/posts/something.png"
comments: true
---

[![]({{ page.landing-image }}){: .bordered.landing-image.centered }]({{ page.landing-image }})

## Add Custom Domains to Heroku App Settings

- go to Settings > Domains
- create two custom domains
- yourdomain.com and www.yourdomain.com
- take note of DNS Target entries for both

## Add Heroku DNS Entries to Cloudflare Domain

- go to Cloudflare and add a site (or manage an existing one)
- go to DNS
- click Add record to add two records for each of the DNS Target entries in Heroku

Type: CNAME
Name: yourdomain.com
IPv4 Address: [DNS Target for yourdomain.com in Heroku]
TTL: Auto

Type: CNAME
Name: www
IPv4 Address: [DNS Target for www.yourdomain.com in Heroku]
TTL: Auto

- take note of the Cloudflare nameservers

## Set Cloudflare Nameservers in Google Domains

- go to Google Domains and buy a new domain (or manage an existing one)
- go to DNS > Name Servers
- click Use custom name servers
- add a new Name server entry for each of the Cloudflare nameservers

## Set Up Cloudflare's SSL Settings

- go back to Cloudflare
- go to SSL/TLS
- select Flexible SSL/TLS encryption mode
- go to SSL/TLS > Edge Certificates
- flip Always Use HTTPS to On

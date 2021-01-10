---
layout: post
title: "Free SSL with Heroku, Cloudflare, and Google Domains"
date: 2021-02-17
landing-image: "/assets/images/posts/something.png"
comments: true
---

[![]({{ page.landing-image }}){: .bordered.landing-image.centered }]({{ page.landing-image }})

Recently, I went through the process of deploying a [small Rails application](https://blubtides.com) on Heroku and registering a custom domain with Google Domains for it. In today's web, [HTTPS encryption](https://www.cloudflare.com/learning/ssl/what-is-https/) is a _must have_, and I wanted it for my new site.

Rather than pay for [Heroku's Automated Certificate Management](https://devcenter.heroku.com/articles/automated-certificate-management), I decided to use [Cloudflare's Free SSL/TLS protection](https://www.cloudflare.com/ssl/) and configure Heroku myself. These are the steps I took to configure Heroku and Google Domains to get free SSL through Cloudflare!

For this example, we'll configure settings for `"www.another-cool-domain.com"`.

## Add Custom Domains to Heroku App Settings

Log in to [Heroku](https://dashboard.heroku.com/apps) and go to **Settings** -> **Domains**. Add two custom domains:

[![](/assets/images/posts/ssl-step-0-heroku-custom-domains.png){: .bordered }](/assets/images/posts/ssl-step-0-heroku-custom-domains.png)

There's an entry for the domain _with_ `"www"` in front of it, and one _without_. Each of the entries has a **DNS Target** created for it. Take note, because these are used in Cloudflare.

## Add Heroku DNS Entries to Cloudflare Domain

Log in to [Cloudflare](https://dash.cloudflare.com/) and click **Manage** for an existing domain (or [create a new one](https://support.cloudflare.com/hc/en-us/articles/201720164-Creating-a-Cloudflare-account-and-adding-a-website#2YulMb5YJTVnMxgAgNWdS2)). At the top of the **DNS** settings dashboard, there there is a section for adding DNS entries. Add two new entries:

[![](/assets/images/posts/ssl-step-1-cloudflare-domain.png){: .bordered }](/assets/images/posts/ssl-step-1-cloudflare-domain.png)

The **IPv4 Address** fields for each of the DNS entries correspond with the **DNS Targets** of the custom domains in Heroku. The entry named `"www"` uses the DNS Target of the custom domain with `"www"` in the front of the domain name.

## Set Cloudflare Nameservers in Google Domains

Below the DNS records, there is a section named **Cloudflare nameservers**:

[![](/assets/images/posts/ssl-step-2-cloudflare-nameservers.png){: .bordered }](/assets/images/posts/ssl-step-2-cloudflare-nameservers.png)

These nameservers need to be set in Google Domains.

Log in to [Google Domains](https://domains.google.com/registrar) and click **Manage** for an existing domain (or [register a new one](https://domains.google/get-started/domain-search/)). Navigate to **DNS** -> **Name servers** and select `Use custom name servers`. Add two entries for each of the nameservers listed in Cloudflare:

[![](/assets/images/posts/ssl-step-3-google-domain.png){: .bordered }](/assets/images/posts/ssl-step-3-google-domain.png)

In Google Domains, the DNS entries might take between several minutes and up to 48 hours to update.

## Set Up Cloudflare's SSL Settings

Back in Cloudflare, go to **SSL/TLS** -> **Overview**. Select `Flexible` for the encryption mode:

[![](/assets/images/posts/ssl-step-4-cloudflare-ssl.png){: .bordered }](/assets/images/posts/ssl-step-4-cloudflare-ssl.png)

Then, go to **Edge Certificates** and flip the switch for **Always Use HTTPS** to `On`.

[![](/assets/images/posts/ssl-step-5-edge-certificates.png){: .bordered }](/assets/images/posts/ssl-step-5-edge-certificates.png)

Once these settings are updated, it shouldn't take more than a couple minutes to reflect. However, it can take up to 24 hours for things to work.

## Conclusion

When everything is set up, visting `"another-cool-domain.com"` should redirect to `"https://another-cool-domain.com"` and `"www.another-cool-domain.com"` should redirect to `"https://www.another-cool-domain"`. And if the application is up and running on Heroku, it should fire right up!

### Resources

* [Stack Overflow: Heroku + Cloudflare completely free SSL](https://stackoverflow.com/q/26131611)
* [Configure Cloudflare and Heroku over HTTPS](https://support.cloudflare.com/hc/en-us/articles/205893698-Configure-Cloudflare-and-Heroku-over-HTTPS)
* [Set up CloudFlare's free SSL on Heroku ](https://thoughtbot.com/blog/set-up-cloudflare-free-ssl-on-heroku)
* [Heroku + Cloudflare: The Right Way](https://www.viget.com/articles/heroku-cloudflare-the-right-way/)

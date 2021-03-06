---
layout: post
title:  Why I left Blogger for Jekyll
date:   2016-03-26
landing-image: "/assets/images/posts/jekyll-css.png"
comments: true
---

After many years on Google's [Blogger](http://www.blogger.com) platform, I've decided to switch over to [Jekyll](http://jekyllrb.com/). The [old site is still up](http://www.runtime-era.blogspot.com), with all of my previous blog posts. However, any new content will be posted here.

There are several reasons I decided to leave Blogger. These are just the important few:

## Full control of the overall design

Blogger makes it really easy to get a blog up and running. There are several default themes to choose from and they're all wonderfully designed. Once a theme is selected, it can be further tweaked. There are built-in tools for selecting colors, fonts, sizes, etc. 

[![Blogger Template Designer](/assets/images/posts/blogger-template-designer.png){: .bordered }](/assets/images/posts/blogger-template-designer.png)

However, doing anything more than colors and fonts requires some pretty hacky stuff. The built-in editor allows custom CSS to be dropped into the page, but it's all mixed in with a bunch of other crud generated by the chosen theme. Doing proper, well-organized CSS is simply out of the question.

[![Blogger CSS Editor](/assets/images/posts/blogger-css-editor.png){: .bordered }](/assets/images/posts/blogger-css-editor.png)

Using Jekyll, **I'm able to build my layouts and styles from the barest HTML and CSS**. It's just a static website, after all. I have complete control over every aspect of the site! If I don't want to build an entire site from scratch, there are [a ton of other themes](http://jekyllthemes.org/) I can choose from.

[![Jekyll CSS](/assets/images/posts/jekyll-css.png){: .bordered }](/assets/images/posts/jekyll-css.png)

## The ability to write blog posts in almost any format

As writers, our main goal is to *produce* interesting content for readers to consume. One of the main purposes of any blogging tool is to make the delivery of content quick and seamless. Blogger provides great tools for pumping out content, including a basic WYSIWYG (what you see is what you get) editor. With it, delivering content is as easy as writing, saving, uploading a picture or two, and clicking "Publish".

[![Blogger Post Editor](/assets/images/posts/blogger-post-editor.png){: .bordered }](/assets/images/posts/blogger-post-editor.png)

However, anything more complex than words or pictures can be painful to produce in a WYSIWYG. Even simple things, like inserting a `<table>` or applying custom CSS classes, require editing the HTML source directly. As expected, the code generated by the WYSIWYG editor isn't very clean. We're talking inline styles and no indentation!

[![Blogger HTML Editor](/assets/images/posts/blogger-html-editor.png){: .bordered }](/assets/images/posts/blogger-html-editor.png)

Jekyll **supports the creation and delivery of content in [several different formats](http://jekyllrb.com/docs/plugins/#converters-1)**. I prefer to deliver most of my articles in [Markdown](https://help.github.com/articles/markdown-basics/). However, if I need to present more complex content, I can write it in raw HTML. Either way, I have more options on how to create content for readers!

[![Jekyll Markdown](/assets/images/posts/jekyll-markdown.png){: .bordered }](/assets/images/posts/jekyll-markdown.png)

## Built-in support for code syntax highlighting

Blogger, by default, doesn't have code syntax highlighting built in. When I first started writing, I didn't think too much about it. As time went on, my posts began to incorporate more and more code. The lack of clean, syntax highlighting became a *major* inconvenience.

I discovered a plugin called [SyntaxHighlighter](http://alexgorbatchev.com/SyntaxHighlighter/) written by [Alex Gorbatchev]() that allowed me to insert highlighted code snippets into my blog posts. However, getting the plugin into Blogger felt [really hacky](http://www.mybloggertricks.com/2015/04/SyntaxHighlighter-Shortcode-for-Blogspot.html).

[![Blogger Syntax Highlighting](/assets/images/posts/blogger-syntax-highlighter.png){: .bordered }](/assets/images/posts/blogger-syntax-highlighter.png)

**With Jekyll, code syntax highlighting is [built right in](http://jekyllrb.com/docs/posts/#highlighting-code-snippets)**. No third-party Javascript is required to transform the page on load. Since Jekyll uses [Pygments](http://pygments.org), it is capable of highlighting [tons of different programming languages](http://pygments.org/languages/). (Update: As of Jekyll 3, the default highlighter is [Rogue](http://rouge.jneen.net/).)

{% highlight ruby %}
# Some Ruby code!
class MyClass
  def initialize
    @my_variable = 'My value!'
  end
end
{% endhighlight %}

## Reduced loading time

Currently, my [Blogger-hosted website](http://www.runtime-era.blogspot.com) loads on an average of 1-2 seconds per page. This isn't too bad, but for something as simple as a blog (with no dynamic content), it's pretty slow.

[![Blogger Profile](/assets/images/posts/blogger-profile.png){: .bordered }](/assets/images/posts/blogger-profile.png)

Since Jekyll is a static site generator, all of the content is generated *prior to deployment*. This means **my entire blog is a collection of pure, [static web pages](https://en.wikipedia.org/wiki/Static_web_page)**. When the client makes a request for a blog post, there is no crazy content-rendering or database querying. A simple, pure HTML web page is sent, which takes an average of 300-500 milliseconds! 

[![Jekyll Profile](/assets/images/posts/jekyll-profile.png){: .bordered }](/assets/images/posts/jekyll-profile.png)

*Disclaimer: These numbers are coming from a couple of runs through the Chrome profiler. Not any type of uber-scientific method. Your results will vary.*

## Conclusion

Blogger is a good platform for writers looking to quickly publish simple content. The default themes and layouts are, at the very least, pleasing to the eye. The WYSIWYG editor is adequate for delivering basic articles, with the option to edit HTML source directly.

However, for bloggers looking for a fine-tuned experience in designing, creating, and delivering the best content to their readers, a static site generator like Jekyll is a *much* better option.

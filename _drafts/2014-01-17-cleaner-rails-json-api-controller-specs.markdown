---
layout: post
title: Cleaner Rails JSON API Controller Specs with OpenStruct
date: '2014-01-17T09:55:00.001-08:00'
author: Frederick Ancheta
tags:
- rspec
- rest
- controller
- api
- spec
- ruby on rails
- json
- test
modified_time: '2014-01-17T09:55:39.998-08:00'
thumbnail: http://1.bp.blogspot.com/-UBh-4QExjq0/UtjnJeq-qAI/AAAAAAAABRs/DfTF07eeI14/s72-c/Screenshot+from+2014-01-17+00:17:19.png
blogger_id: tag:blogger.com,1999:blog-9008563869490582540.post-8105068639790692025
blogger_orig_url: http://www.runtime-era.com/2014/01/cleaner-rails-json-api-controller-specs.html
---

[![](http://1.bp.blogspot.com/-UBh-4QExjq0/UtjnJeq-qAI/AAAAAAAABRs/DfTF07eeI14/s320/Screenshot+from+2014-01-17+00:17:19.png)](http://1.bp.blogspot.com/-UBh-4QExjq0/UtjnJeq-qAI/AAAAAAAABRs/DfTF07eeI14/s1600/Screenshot+from+2014-01-17+00:17:19.png)

\
 As many of us know, Ruby on Rails makes it really easy to write RESTful
APIs. Paired with a rich client-side framework, we can create
applications with slick user interfaces. A common approach for this is
to write JSON APIs on the server for consumption by a Javascript
front-end framework. To test my APIs, I like to use
[RSpec](http://rspec.info/) and build specs for the actions on each of
the controllers. The goal of the tests is to make sure each JSON
response returns the correct information in the proper structure. \
\
 TL;DR [Example code on
Github](http://github.com/era86/articles/blob/master/spec/controllers/articles_controller_spec.rb)\
\
 How about an example? Let's say we have a model named **Article**:

~~~~ {.brush: .ruby}
class Article < ActiveRecord::Base  attr_accessible :title, :bodyend
~~~~

Following standard TDD practices, we begin by writing a test. Here's a
first crack at a controller spec describing the **create** action on our
**ArticlesController**:

~~~~ {.brush: .ruby}
describe ArticlesController do  describe '#create' do    let(:title)  { 'New Title' }    let(:body)   { 'New Body' }    let(:attrs)  {{ "{{" }} title: title, body: body }} # our new Article    let(:params) {{ "{{" }} format: :json, article: attrs }}    before { post :create, params } # make the request    it 'creates a new Article' do      Articles.all.count.should == 1    end    it 'returns the title' do      response.body.should include(title)    end    it 'returns the body' do      response.body.should include(body)    end  endend
~~~~

The first assertion makes sure an Article was actually created. The next
two assertions check the response. A successful creation should return
the new Article's attributes in a JSON object. With the spec written, we
can implement our controller:

~~~~ {.brush: .ruby}
class ArticlesController < ApplicationController  respond_to :json    def create    @article = Article.new(params[:article])    if @article.save      render json: @article # { title: 'New Title', body: 'New Body' }    end  endend
~~~~

When we run our test, it passes. However, our test is incorrect! What
if, for some odd reason, the title and body were actually swapped in the
response (title has body, body has title)? The test would still pass!
While our spec ensures the correct values are in the response, it
doesn't ensure the proper structure. Let's try again:

~~~~ {.brush: .ruby}
describe ArticlesController do  describe '#create' do    let(:title)  { 'New Title' }    let(:body)   { 'New Body' }    let(:attrs)  {{ "{{" }} title: title, body: body }}    let(:params) {{ "{{" }} format: :json, article: attrs }}    before { post :create, params }    # removed Article count for brevity    subject { JSON.parse(response.body) }    it 'returns the title' do      subject['title'].should == title    end    it 'returns the body' do      subject['body'].should == body    end  endend
~~~~

In this version, we make our test more descriptive by declaring our
response object as the [subject](http://betterspecs.org/#subject). We
also parse our response into a Hash by using **JSON.parse()** in the
standard [Ruby
JSON](http://www.ruby-doc.org/stdlib-2.0.0/libdoc/json/rdoc/JSON.html)
library. Now, our assertions make sure we get the correct attributes
from the proper keys in the response object. We also get the added bonus
of ensuring a valid JSON response by parsing it in our subject. \
\
 Our test is now correct, but it can still be improved. When I'm testing
JSON responses, I like to use
[OpenStruct](http://www.ruby-doc.org/stdlib-2.0/libdoc/ostruct/rdoc/OpenStruct.html)
to clean up my assertions. In simple terms, an OpenStruct takes a Hash
and returns an object with methods named according to each key in the
Hash. So, we can make the keys in our JSON response behave like methods
on an object! Using OpenStruct, here is a prettier version of our test:

~~~~ {.brush: .ruby}
describe ArticlesController do  describe '#create' do    let(:title)  { 'New Title' }    let(:body)   { 'New Body' }    let(:attrs)  {{ "{{" }} title: title, body: body }}    let(:params) {{ "{{" }} format: :json, article: attrs }}    before { post :create, params }    subject { OpenStruct.new(JSON.parse(response.body)) }    its(:title) { should == title }    its(:body) { should == body }  endend
~~~~

Compared to our first draft, this spec is more concise, correct, and
straightforward. \
\
 How do you like to use OpenStructs? Any thoughts, tips, and tricks are
appreciated. Let me know in the comments!

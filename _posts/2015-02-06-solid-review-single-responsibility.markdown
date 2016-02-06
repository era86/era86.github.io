---
layout: post
title: 'SOLID Review: Single Responsibility Principle'
date: 2015-02-06
comments: true
---

[![Knife](/assets/images/posts/knife.jpg){: .bordered.landing-image.centered }](/assets/images/posts/knife.jpg)

*Note: This is part of a series of articles reviewing the [five SOLID Principles of object-oriented programming](http://en.wikipedia.org/wiki/SOLID_%28object-oriented_design%29).*

The Single Responsibility Principle was first coined by Robert Martin in an article on the [Principles of Object Oriented Design](http://butunclebob.com/ArticleS.UncleBob.PrinciplesOfOod). To this day, it remains an important design principle because it encourages a lowly-coupled system with highly-cohesive classes. This type of system is much more maintainable because it is easier to modify.

Before we dive into the principle itself, we need to address two important concepts in object-oriented programming: **coupling** and **cohesion**.

## Coupling

Coupling is used to describe **the degree of dependency between individual classes**. Classes are "highly coupled" if one class is directly affected by the behavior of another class in the system. If many classes are dependent on each other, a change in one may lead to a breaking ripple effect! This makes the system hard to change because many more parts need to be tested, fixed, and deployed.

We should **always strive for classes that aren't too dependent on each other**. This leads to a "lowly coupled" system, which is much easier to maintain.

## Cohesion

Cohesion is used to describe **the degree of similarity between the internal elements of a single class**. A class with a variety of methods spanning many unrelated behaviors is said to have "low cohesion". If a class is designed this way, it will have dependencies with several unrelated classes. This leads to a monolithic class with tangles over many different parts of the system!

We should **always strive for classes that encapsulate very closely-related behaviors**. This leads to a set of "highly cohesive" classes, making it easier to decouple different parts of the system.

## Cohesion and Decoupling through Single Responsibility

Robert Martin describes the Single Responsibility Principle as:

> "A class should have only one reason to change."

In other words, a class should be responsible for providing only one specific function or behavior in a given system. When a class only has one responsibility, its internal elements are sure to be closely related, making it very highly cohesive. A system with many small, focused classes will have less dependencies because no single class will have to interact with too many other classes. This helps keep the system lowly coupled.

Let's look at a simple example.

## Breaking Down a Monolithic Class

Suppose we have a simple class for representing bodies of text. We'll call it `Document`:

{% highlight ruby %}
class Document
  attr_accessor :author, :text
 
  def initialize(author, text)
    @author = author
    @text = text
  end
 
  def save_to_file(filename)
    File.open(filename, 'w') do |file|
      file.write(full_text)
    end
  end
 
  def print_as_pdf
    pdf_creator = PDFCreator.new(full_text)
    pdf_creator.print
  end
 
  def print_as_html
    html_creator = HTMLCreator.new(full_text)
    html_creator.print
  end
 
  def send_to_email(email)
    email_sender = Mailer.new(email)
    email_sender.send(full_text)
  end
 
  def full_text
    "Author: #{@author}, Text: #{@text}"
  end
end
{% endhighlight %}

Here is a list of all the behaviors Document is responsible for:

* Saving the text to disk.
* Printing the text as a PDF or HTML page.
* Sending the text via email.

This class lacks cohesion because it has various groups of methods each serving different purposes. Since many other classes may need to save, print, and send Documents, they will have to couple to this single, monolithic class.

How about we break up each individual responsibility into its own class?

## Small, Single-Responsibility Classes

Using our list of behaviors, we'll create new classes for each responsibility.

### Saving the text to disk

We'll create a class whose sole purpose is to save text to the file system. We'll call it `DocumentFile`: 

{% highlight ruby %}
class DocumentFile
  def initialize(filename, document)
    @filename = filename
    @document = document
  end
 
  def save!
    File.open(filename, 'w') do |file|
      file.write(document.full_text)
    end
  end
end
{% endhighlight %}

Now, our `Document` can make use of `DocumentFile` to write its text contents to disk:

{% highlight ruby %}
document = Document.new('Thomas Harris', 'The story of Silence of the Lambs...')
file = DocumentFile.new('silence.txt', document)
 
data_file.save!
{% endhighlight %}

If we wanted to add the ability to load an existing Document from the file system, we have a dedicated class for doing file input/output. We don't have to clutter our Document class to add functionality.

### Printing the text as a PDF or HTML page.

We'll extract any methods for printing different formats out into a class called `DocumentPrinter`. This will make use of two imaginary Gems named `PDFCreator` and `HTMLCreator`. Their implementations aren't important, but it helps describe the behavior of the methods:

{% highlight ruby %}
class DocumentPrinter
  def initialize(document)
    @document = document
  end
 
  def print_as_pdf
    pdf_creator = PDFCreator.new(@document.full_text)
    pdf_creator.print
  end
 
  def print_as_html
    html_creator = HTMLCreator.new(@document.full_text)
    html_creator.print
  end
end
{% endhighlight %}

Simple enough. Now, we have a class dedicated to printing different formats of our `Documents`:

{% highlight ruby %}
document = Document.new('Stephen King', 'The story of Birds...')
document_printer = DocumentPrinter.new(document)
 
document_printer.print_as_pdf # Results in PDF data being printed to screen.
document_printer.print_as_html # Results in HTML being printed to screen.
{% endhighlight %}

Exercise: This could be taken even further by breaking each method and creating two new classes: `DocumentPDFPrinter` and `DocumentHTMLPrinter`. Each could implement a Printer interface. This might be a good idea, since we may require printing of other formats in the future.

### Sending the text via email.

Finally, we'll create a new class whose sole responsibility is to send the Document to someone via email. Again, this will make use of an imaginary Gem named `Mailer`. We'll call our new class `DocumentSender`:

{% highlight ruby %}
class DocumentSender
  def initialize(document)
    @document = document
  end
 
  def send_to_email(email)
    email_sender = Mailer.new(email)
    email_sender.send(@document.full_text)
  end
end
{% endhighlight %}

Now, we have a class whose only responsibility is sending a `Document` over email.

{% highlight ruby %}
document = Document.new('Stephen King', 'The story of Birds...')
document_sender = DocumentSender.new(document)
 
document_sender.send_to_email('test@test.com') # Sends text in document to test@test.com.
{% endhighlight %}

## Conclusion

In the end, we have three individual classes, each with their own responsibilities. If we need to add another feature, we can create another class without affecting any of the existing classes. We can more easily modify existing functionality because we can pinpoint where changes need to be made based on each responsibility.

This whole example can be taken even further by making our `Sender` and `File` more generic. In other words, decouple them from Document by taking any data and sending or saving it. I'll leave that as an exercise for the reader.

Happy coding!

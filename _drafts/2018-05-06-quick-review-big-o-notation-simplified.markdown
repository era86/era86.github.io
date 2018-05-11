---
layout: post
title:  "Quick Review: Big-O Notation Simplified"
date:   2018-05-06
landing-image: "/assets/images/posts/"
comments: true
---

[![](/assets/images/posts/){: .landing-image.centered }](/assets/images/posts/)

As a web developer, I very rarely find myself deeply analyzing algorithms. However, it'd be hard to step into a technical interview without being asked about Big-O analysis. It's actualy quite useful for software engineers to have a basic understanding of Big-O notation. It provides a common language for us to discuss the performance of our code and the potential ways we can improve it.

## What is Big-O notation?

As you may already know, algorithms are made up of a set of operations. Generally, the more complex an algorithm, the longer it takes to run. How can we get a better view of an algorithm's performance based on its complexity?

Big-O notation is a way to express an algorithm's complexity in terms of the size of its input. It gives us an idea of how an algorithm scales as its input grows. An algorithm can be classified into one of several Big-O functions, like `O(n)` or <code>O(n<sup>2</sup>)</code>. With these order functions, we can compare the complexity (and performance) of our algorithms.

## A Basic Example

Let's walk through a very basic example. Here's a simple search function:

{% highlight python %}
def linear_search(target, list):
  for item in list:
    if target == item:
      return True
  return False
{% endhighlight %}

### Determine the Input Size `n`

The number of elements in `list` is our input size, `n`. As `list` grows, `n` grows.

### Only Consider the Worst-Case Scenario

If the first item in `list` is equal to `target`, then we complete in a single operation. This is the best-case scenario. We really only care about the worst-case scenario, which occurs when `target` doesn't exist in `list`.

### Express the Number of Operations as a Function

We can determine how many operations we need to perform (in the worst case) as a function of `n`. Loops are often a big clue that we're iterating over the elements of our input. In this case, we have one loop.

### Ignore the Small Stuff

Loops are usually a big clue in determining the complexity of an algorithm. One loop usually means we'll operate on each item at least once. This means our code above has a Big-O complexity of `O(n)`. If `list` has 10 items, it will take (at most) 10 operations to complete. We say "at most", because when it comes to Big-O, we only care about the worst-case situation.

For our 

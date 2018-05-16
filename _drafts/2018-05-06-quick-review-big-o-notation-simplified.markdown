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
def linear_search(target, items):
  for item in items:
    if target == item:
      return True
  return False
{% endhighlight %}

### Determine the Input Size

The number of elements in `items` is our input size, `n`. As `items` grows, `n` grows.

### Only Consider the Worst-Case Scenario

If the first item in `items` is equal to `target`, then the function exits in a only one operation. This is the best-case scenario. We really only care about the worst-case scenario, which occurs when `target` doesn't exist in `items` at all. In this situation, we end up iterating through the entire list.

### Express the Number of Operations as a Function

We can determine how many operations we need to perform (in the worst case) as a function of `n`. Since we know our worst case involves iterating the entire list, the Big-O complexity of our function is `O(n)`. In other words, if `items` has 10 items, we do 10 operations. If it has 1000 items, we do 1000 operations. And so on.

### Ignore the Small Stuff

Let's say we expanded a bit on our function:

{% highlight python %}
def print_and_linear_search(target, items):
  for item in items:
    print item

  for item in items:
    if target == item:
      return True
  return False
{% endhighlight %}

Now, we have two loops in our function: one for printing and one for searching. This means our function now has `2n` operations in its worst case scenario. Since Big-O is an approximation on _arbitrarily large values of `n`_, we can drop less significant terms. So, we can stil express the complexty of our function as `O(n)`, even if it _really_ has `2n` operations.

## Different Big-O Classifications

Now that we have an understanding of Big-O analysis, we can look at some common classes of algorithm complexities.

### `O(1)`

This is known as "constant time" because the algorithm completes in the same amount of time no matter what the size of the input is. An example of this is pushing or popping from a stack:

{% highlight python %}
def push(item, items):
  items[len(items):] = [x]

def pop(items)
  item = items[-1]
  del items[-1]
  return item
{% endhighlight %}

Regardless of how big `items` is, we still yield the same amount of operations.

### `O(n)`

This is known as "linear time" because the algorithm completes within one full iteration of the size of the input. We've already seen an example of this above in our `linear_search` function.

As the input grows, the the number of operations grows _linearly_ with it.

### `O(log(n))`

Let's take a step back and visit our searching algorithm from before. For the sake of this example, let's assume our input is a list of sorted items. With this assumption, we can drastically reduce the runtime complexity of our search:

{% highlight python %}
def binary_search(item, sorted_items):
  mid = len(sorted_items) / 2

  return True if sorted_items[mid] == item

  if item < mid:
    return binary_search(item, sorted_items[0, mid])
  else:
    return binary_search(item, sorted_items[mid, -1])
{% endhighlight %}

This approach is commonly known as "divide and conquer". Rather than looping through all items, divide-and-conquer algorithms halve the input size, recursively, at each step. This results in an algorithmic complexity resembling a logarithmic function, thus the Big-O complexity of `O(log(n))`.

### `O(nlog(n))`

### <code>O(n<sup>2</sup>)</code>

### <code>O(2<sup>n</sup>)</code>

### `O(n!)`

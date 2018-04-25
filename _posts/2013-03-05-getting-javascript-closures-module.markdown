---
layout: post
title: Getting JavaScript Closures (The Module Pattern)
date: 2013-03-05
landing-image: "/assets/images/posts/mints.jpg"
comments: true
---

[![Mints]({{ page.landing-image }}){: .bordered.landing-image.centered }]({{ page.landing-image }})

JavaScript is an essential tool for any web developer. There is no denying the [rise in popularity](http://techcrunch.com/2012/09/12/javascript-tops-latest-programming-language-popularity-ranking-from-redmonk/) of the language. Since its inception, JavaScript has been used, abused, and misunderstood by many programmers. Classically trained developers (such as myself) often find it difficult to grasp programming in "the JavaScript way". When I first started learning JavaScript, a common concept I struggled with was the usage of [closures](https://developer.mozilla.org/en-US/docs/JavaScript/Guide/Closures).

## Variable Scope

To understand closures, we must understand JavaScript scoping. Scope refers to the context in which a variable is accessible. This can be one of two types: **global** or **local**. A variable with **global scope** is accessible from anywhere within the program.

{% highlight javascript %}
// declared outside of any function
var globalVar1 = 'I am visible everywhere.';
 
function myFunc() {
  // declared without 'var' keyword
  globalVar2 = 'I am ALSO visible everywhere!'; 
}
{% endhighlight %}

A variable with **local scope** is only visible from a specific part of code. In JavaScript, variables have function scope. This means a variable declared in a function is available only from within that function.

{% highlight javascript %}
var globalVar = 'I am visible everywhere.'
 
function myFunc() {
  // declared from within a function
  var localVar = 'I am only visible in myFunc!'; 
}
{% endhighlight %}

A function may have many local variables defined within it, but it also has access to all variables in any scope enclosing it (including the global scope). This is known as the **scope chain**.

{% highlight javascript %}
function outerFunc() {
  var outerVar = 'I am visible to outerFunc, midFunc, and innerFunc!';
 
  function midFunc() {
    var midVar = 'I am visible to midFunc and innerFunc.';
 
    function innerFunc() {
      var innerVar = 'I am only visible to innerFunc...';
    }
  }
}
{% endhighlight %}

Functions also have access to the **parameters** of an enclosing scope.

{% highlight javascript %}
function outerFunc(param) {
  function innerFunc() {
    // param is visible from innerFunc
    var innerVar = 'The param is: ' + param; 
  }
}
{% endhighlight %}

Understanding the scope chain is essential to understanding closures!

## Getting Some Closure

A closure is created when a function references variables from its enclosing context. Or simply put, when an inner function references variables from an outer function. Even if the outer function exits, the inner function holds a reference to any variables it has referenced from the outer function, including the entire scope chain.

{% highlight javascript %}
function createPersonalGreeting(name) {
  var greeting = 'Hello there';
 
  // an inner function with access to 'name' and 'greeting'
  var greetFunc = function() {
    // reference outer function variables, a closure is formed!
    return greeting + ', ' + name; 
  }
 
  // even after return, greetFunc still has access to 'name' and 'greeting'
  return greetFunc; 
}
 
var helloFred = createPersonalGreeting('Fred');
console.log(helloFred()); // Hello there, Fred
 
var helloAshley = createPersonalGreeting('Ashley');
console.log(helloAshley()); // Hello there, Ashley
{% endhighlight %}

After we call `createPersonalGreeting`, it returns the inner function (`greetFunc`) and exits. All of its local variables are completely hidden from us. Remember, though, the inner function we get back from `createPersonalGreeting` can still reference those seemingly "lost" variables. So, when we call `helloFred`, it remembers the name "Fred" and the greeting "Hello there".

## Organizing Code with Modules

One particular design pattern that makes use of closures is the **Module Pattern**. When organizing JavaScript code, we have to be careful not to pollute the global scope with all sorts of variables and functions. One way to do this is to encapsulate any related code into its own module object. By doing this, we can pick and choose what we want to expose to the global scope.

Before we continue, we introduce a new technique known as an **Immediately Invoked Function Expression (IIFE)**. It does exactly what it's called.

{% highlight javascript %}
(function(){
  var myVar = 'Hello World!';
  console.log(myVar); // Hello World!
})(); // immediately invoke the function we just defined
{% endhighlight %}

Now, we have everything we need to know to create a module. Let's say our application is a simple Hello World program. We could stuff everything for our application in the global scope, but we are better programmers than that! We'll pack all the logic into a module and expose a pretty little interface for working with it.

{% highlight javascript %}
var HelloWorld = (function(){
  // a private variable to hold settings
  var settings = {
    name: 'Fred',
    greeting: 'Hello'
  }; 
 
  // a private function, used only within the IIFE
  function buildGreeting() {
    return settings.greeting + ', ' + settings.name + '!';
  }
 
  // an object with the module's public interface
  return {
    sayHello: function() {
      console.log(buildGreeting());
    }
  }
})();

HelloWorld.sayHello(); // Hello, Fred!
{% endhighlight %}

We can use the `HelloWorld` module's public function, `sayHello`, to display a greeting to the console. Any variables or functions used by the module is contained within the IIFE. The only way to interact with the internals of the module is through the public interface we've specified in the returned object.

Let's expose some functions to set the name and greeting of our `HelloWorld` module. All we have to do is add two new functions to our return object.

{% highlight javascript %}
var HelloWorld = (function(){
  ... // left out other code for brevity

  return {
    setName: function(name) {
      settings.name = name;
    },
 
    setGreeting: function(greeting) {
      settings.greeting = greeting;
    }
  }
})();

HelloWorld.sayHello(); // Hello, Fred!

HelloWorld.setName('Ashley');
HelloWorld.sayHello(); // Hello, Ashley!

HelloWorld.setGreeting('Good day');
HelloWorld.sayHello(); // Good day, Ashley!
{% endhighlight %}

Now, our module allows us to change its internal state, but only via the public interface we've exposed.

That's all there is to it! Feel free to let me know your favorite ways to use JavaScript closures in the comments below.

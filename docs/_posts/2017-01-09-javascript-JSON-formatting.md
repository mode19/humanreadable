---
layout: post
title:  "A quick tip to format JSON objects in JavaScript"
date:   2018-01-09
categories: javascript
---

A look at using [JSON.stringify](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify) to format and indent JavaScript objects.


For example, take the following JavaScript object:

{% highlight javascript %}
var json = {
 test : 1, 
 arr : [
  {a : 1},
  {b : 2}
 ]
};
{% endhighlight %}

formatted with the line of code:

{% highlight javascript %}
var str = JSON.stringify( json, null, 4);
{% endhighlight %}

The end result is a string that is nicely formatted and readable:

```
{
    "test": 1,
    "arr": [
        {
            "a": 1
        },
        {
            "b": 2
        }
    ]
}
```

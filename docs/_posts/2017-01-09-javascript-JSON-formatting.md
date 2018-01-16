---
layout: post
title:  "A quick tip to format JSON objects in JavaScript"
date:   2018-01-09
categories: javascript
---

A quick way to convert a JavaScript object to a formatted and indented string is to use the [JSON.stringify](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify) function.


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

Pass it to the stringify function with the following parameters:

{% highlight javascript %}
var str = JSON.stringify( json, null, 4);
{% endhighlight %}

The end result is a string that is indented and formatted as a JSON string:

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

---
layout: post
title:  "JavaScript Quick Tip: Stringifying an Object with Indentation"
date:   2018-01-09
categories: javascript
---

In JavaScript the [JSON.stringify](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify)Stringify method provides a way of converting a JavaScript object to a string.  This function also has a feature to add linebreaks and indentation as a quick way to make the string more readable which can help during troubleshootin.


For example, take the following JavaScript object:

{% highlight javascript %}
var obj = {
 test : 1, 
 arr : [
  {a : 1},
  {b : 2}
 ]
};
{% endhighlight %}

Pass it to the stringify function with the following parameters:

{% highlight javascript %}
var str = JSON.stringify( obj, null, 4);
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

---
layout: post
title:  "VIM Quick Tip: The Global Command"
date:   2018-01-09
categories: vim
---

For vim users, one of the most useful commands to know is the global command. The global command applies an operation to all lines which match (or do not match) a specified pattern.

To see the formal help page enter the following into vim:

    help :g

The example below looks specifically at the delete (or 'd') command, but there are many others that can be used.  To see more commands enter:

    help ex-cmd-index

A common use is to delete lines from a file matching a pattern.  For example:

If we wanted to remove all the lines containing 'grapefruit' from the following file:

```
Michael Jackson
grapefruit1
Joe Cocker
grapefruit2
Bruce Springsteen
grapefruit3
Aretha Franklin
grapefruit4
```

we would enter the command

    :g/grapefruit/d

and be left with:


```
Michael Jackson
Joe Cocker
Bruce Springsteen
Aretha Franklin
```

Alternatively, we could remove the lines NOT containing 'grapefruit' as follows:

    :g!/grapefruit/d 

and be left with:

```
grapefruit1
grapefruit2
grapefruit3
grapefruit4
```

Using more complex patterns can make this command invaluable when cleaning up data files.


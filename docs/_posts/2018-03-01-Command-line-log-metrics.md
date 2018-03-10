---
layout: post
title:  "Command-line Log Metrics: cat, grep, sed, uniq, sort, wc and awk"
date:   2018-03-02
categories: awk, UNIX
---

## Introduction
  When troubleshooting software we usually don't have all the required information in one place. Often we only have command-line access to low level application and system log files.
  Command line tools such as tail, cat, grep etc. can be combined to provide basic insights into application performance.
Lets look at some examples of how to use standard UNIX command-line tools to analyze application log files.

## Prerequisites
 * Be comfortable using the UNIX command line utilities such as [cat](https://en.wikipedia.org/wiki/Cat_(Unix)), [tail](https://en.wikipedia.org/wiki/Tail_(Unix)), [grep](https://en.wikipedia.org/wiki/Grep) etc.
 * Have access to the calc.sh (or some alternative) script which can calculate average/median/minimum and maximum times. See the corresponding guide [Quick and Dirty Software Metrics using Awk](https://mode19.github.io/humanreadable/awk,/unix/2018/03/01/Quick-and-dirty-software-metrics-using-awk.html)

## Why?

 Lets look at real world situation: a customer has complained that some operations in the system are taking too long. Luckily the developer included some logging in the application that records how long each operation takes. If we view the log file directly we can see an entry for every event that occurred. Now imagine this log contains thousands or millions of records? How will we identify which events are being triggered in the system? How frequently are certain types of events occurring? How long does each type of event take to process (Average, minimum, maximum time etc)? The below guide is a step by step example of how to calculate these kinds of metrics.

 Imagine a logfile that looks as follows: 

```
2018-03-03 12:00:14 SOFTWAREPROGRAM MODULE DEBUG [sessiony] processing event #1 took 20440 ms
2018-03-03 12:00:15 SOFTWAREPROGRAM MODULE INFO [sessionx] processing event #1 took 20440 ms
2018-03-03 12:00:16 SOFTWAREPROGRAM MODULE DEBUG [sessiony] processing event #1 took 20440 ms
2018-03-04 12:00:24 SOFTWAREPROGRAM MODULE ERROR [sessionx] processing event #1 took 20440 ms
2018-03-04 12:01:04 SOFTWAREPROGRAM MODULE DEBUG [sessiony] processing event #1 took 16628 ms
2018-03-04 12:02:53 SOFTWAREPROGRAM MODULE DEBUG [sessionx] processing event #0 took 11418 ms
2018-03-04 12:03:00 SOFTWAREPROGRAM MODULE INFO [sessiony] processing event #1 took 28995 ms
2018-03-04 12:04:44 SOFTWAREPROGRAM MODULE DEBUG [sessionx] processing event #1 took 28166 ms
2018-03-04 12:04:44 SOFTWAREPROGRAM MODULE DEBUG [sessiony] processing event #0 took 26063 ms
2018-03-04 12:04:44 SOFTWAREPROGRAM MODULE INFO [sessionx] processing event #1 took 27168 ms
2018-03-04 12:07:31 SOFTWAREPROGRAM MODULE DEBUG [sessionz] processing event #0 took 30484 ms
2018-03-04 12:08:44 SOFTWAREPROGRAM MODULE DEBUG [sessionx] processing event #1 took 27769 ms
2018-03-04 12:09:07 SOFTWAREPROGRAM MODULE DEBUG [sessionz] processing event #1 took 16378 ms

```
## Filtering and Counting Events

When faced with thousands of records, the first step is to filter out the records we are not interested in.  We do this by identifying a set of specific key words that we are interested in, and we chose these key words so that they uniquely identify the event we are interested.  For example, searching for "event #1" might also match "event #11", so in order to uniquely identify "\sevent #1\s" we would have to also include the surrounding white-space as part of the matching expression. In this example only 2 events so we can safely filter "event #1". See the examples below to filter out unwanted records by using [grep](https://en.wikipedia.org/wiki/Cut_(Unix)) and counting the remaining ones using the [wc](https://en.wikipedia.org/wiki/Wc_(Unix)) utility .


How many events happened on March 3rd?

    cat logfile.txt  | grep "2018-03-03" | wc -l
    3

How many events happened on March 2nd? 

    cat logfile.txt  | grep "2018-03-02" | wc -l
    0

How many events of type "event #1" happened on March 4th?

    cat logfile.txt  | grep "2018-03-04" | grep "event #1" | wc -l
    7

How many events happened for sessionz on March 4th? 

	cat logfile.txt  | grep "2018-03-04" | grep "event #1 " | grep "\[sessionz\]" | wc -l
	1

N.B Notice the regular expression to match the session identifier sessionz includes the surround delimiters.  This avoids situations where sessionz could become a false positive for sessionzz or sessionz1 etc.

## Cutting and Counting

We can use the [cut](https://en.wikipedia.org/wiki/Cut_(Unix)) command to isolate specific fields.  This way we can aggregate data over specific groups such as time. Using the [sort](https://en.wikipedia.org/wiki/Sort_(Unix)) and [uniq](https://en.wikipedia.org/wiki/Uniq) utilities we can count the unique number of occurrences of each event by group.

For example, how many events are happening per day?

    cat logfile.txt | cut -f1 -d" " | sort | uniq -c
    3 2018-03-03
    10 2018-03-04

How many events are happening per second?

    cat logfile.txt | cut -d " " -f1,2   | uniq -c
    1 2018-03-03 12:00:14
    1 2018-03-03 12:00:15
    1 2018-03-03 12:00:16
    1 2018-03-04 12:00:24
    1 2018-03-04 12:01:04
    1 2018-03-04 12:02:53
    1 2018-03-04 12:03:00
    3 2018-03-04 12:04:44
    1 2018-03-04 12:07:31
    1 2018-03-04 12:08:44
    1 2018-03-04 12:09:07

## What is the Average Processing Time of Event #0?

  In order to isolate the log entries containing "event #0" and identifying only the processing time we can produce a list of all corresponding processing times.

    cat logfile.txt  | grep "event #0 "
    2018-03-04 12:2:53 SOFTWAREPROGRAM MODULE DEBUG processing event #0 took 11418 ms
    2018-03-04 12:5:21 SOFTWAREPROGRAM MODULE DEBUG processing event #0 took 26063 ms
    2018-03-04 12:7:31 SOFTWAREPROGRAM MODULE DEBUG processing event #0 took 30484 ms

What are just the response times? Using the [sed](https://en.wikipedia.org/wiki/Sed) utility substitution command to replace the entire line with only the portion in between the word 'took ' and the word ' ms':

    cat logfile.txt  | grep "event #0" | sed -ne 's/.*took \([0-9]*\) ms/\1/p'
    11418
    26063
    30484

Now how do we make sense of this data?  Especially if the result contains hundreds or thousands of records, how can we begin to understand the data?  One quick way is to calculate the average, minimum and maximum values.  This can be done using an awk script (For details on the calc.sh script reference the blog post [here](https://mode19.github.io/humanreadable/awk,/unix/2018/03/01/Quick-and-dirty-software-metrics-using-awk.html)):

    cat logfile.text | grep "event #0" | sed -ne 's/.*took \([0-9]*\) ms/\1/p' | ~/bin/calc.sh
    sum     count   average medium  min     max
    67965   3       22655   26063   11418   30484

## Conclusion and Next Steps

  Using these techniques we can analyze large log files to search for specific values or events. These techniques can work when querying a single file or combining multiple files together. Also, since these techniques are done on the command-line they can be easily scripts and repeated or executed in an automated fashion.  With a few basic scrips one can develop sophisticated techniques for measuring software metrics. Check back for future articles on how to take these metrics and seamlessly create graphs using the gnuplot command-line utility. 

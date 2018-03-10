---
layout: post
title:  "Quick and Dirty Software Metrics using Awk"
date:   2018-03-01
categories: awk, UNIX
---

## Introduction
  When troubleshooting software we don't often have the luxury of a metrics dashboard or a monitoring system. Frequently we are patching together data from different sources and using only command-line access. The UNIX command line has lots of great text processing utilities such as cat, tail, grep, awk etc, however, numerical analysis can be challenging on the command-line.
  In this example we show how to calculate basic metrics such as average/median/minimum and maximum using an awk script.

## Prerequisites
 * Basic familiarity with UNIX command line utilities such as cat, tail, grep etc

## How to make Sense of a List of Numbers?

With computers we are constantly dealing with vast quantities of data and numbers. 

![Matrix Numbers](/humanreadable/assets/images/green_numbers.png)

The image above looks a bit intimiating, so lets break it down to a simpler example such as this file below: numbers.txt. This could be a list of response times for a software service, or an average number of monthly logins for a certain type of customers, it could be a monetary amount such as a list of prices paid for a service. Given this list of numbers how do we begin to make sense of it and analyze it?

```
cat numbers.txt
22
12.1
11
12
3434
29343
138
392
19342
23991
19923
23
9144
```
One way is to using a UNIX script to calculate some basic metrics such as averages. We can [cat](https://en.wikipedia.org/wiki/Cat_(Unix)) the file to standard output and pipe the data into our script as follows:

```
cat numbers.txt | ~/bin/calc.sh 
sum     count   avg     median  min     max
105787  13      8137.47 392     11      29343
```
Lets look at how to create our own calc.sh script using the UNIX text processing utility <a href="https://en.wikipedia.org/wiki/AWK">Awk</a>.

## What is awk

  <a href="https://en.wikipedia.org/wiki/AWK">Awk</a> is command-line text processor that can be used to quickly process text input. An awk program works by parsing an input file into records and each record is broken down into fields. By default, records are delimited by new line characters and fields are demarcated by any white-space characters. However, records and fields can be controlled by the awk RS (record-separator) and FS (field-separator) variables. By default the separators are character types, but can also be regular expressions.

  Once the data is parsed into records and fields and awk program consists of condition-command pairs that are applied to each input record. If the condition is true for that record then the command is executed. The program is over when all the records have been processed making it ideal for filtering or counting of events.
  
  In addition to processing for each record a BEGIN and END section are executed unconditionally before and after processing of the records.

  Lets dive right into our program to see an example.

## Using awk to measure Average, Minimum, Maximum and Medium times

  Copy the following awk script into your ~/bin/calc.sh file:

```
#!/bin/bash

# This bash script expects to be fed a line-separated list of numbers and will print out the sum/count/average/medium/min/max encountered.
# based on a script from: https://unix.stackexchange.com/questions/13731/is-there-a-way-to-get-the-min-max-median-and-average-of-a-list-of-numbers-in

sort -n | awk '
  BEGIN {
    c = 0;
    sum = 0;
    OFS="\t";
    print "sum","count", "average", "medium", "min", "max"
  }
  $1 ~ /^[0-9]*(\.[0-9]*)?$/ {
    a[c++] = $1;
    sum += $1;
  }
  END {
    ave = sum / c;
    if( (c % 2) == 1 ) {
      median = a[ int(c/2) ];
    } else {
      median = ( a[c/2] + a[c/2-1] ) / 2;
    }
    print sum, c, ave, median, a[0], a[c-1];
}
'
```

Don't forget to assign executable permission to the script:

    chmod +x ~/bin/calc.sh

## The BEGIN Section
  The first block of the program called 'BEGIN' is a special section that gets executed before any records are processed. In this case we use the begin block to initialize two variables to 0 and to print out a header line to standard output.


## The Middle Block
The middle section of the program is an awk condition-command pair that gets executed for every input record. Lets look at the awk condition in detail: '$1 ~ /<REGULAREXPRESSION>/':

|Awk condition component | Meaning
|---
|:----:|:---
| $1 | $1 in awk represents the first field encountered in this record.
| ~ | A ~ character attempts to match a value to a regular expression 
| / regular-expression  / | The regular expression is written between two '/' characters

<br/>
The regular expression ^[0-9]*(\.[0-9]*)?$ will match all numbers and exclude any input lines which are non numbers or contain non-numeric characters (See table below for details).

|Regular Expression Component | Meaning
|---
|:----:|:---
| ^ | Regular expression to match from the beginning of the field
| [0-9]* | Match a series of numbers
| (\.[0-9]*)? | Match an optional decimal component to the number
| $ | Marks the end of the field
|===

The expression above ensures every number that appears in the input is processed by our awk command 'a[c++] = $1'. With this command we are saving each input field into an array so that we can calculate the median later. Also by incrementing a 'sum' variable we are keeping a running total of all values encountered.

## The END Block
The END section is executed after all input records have been processed. After processing each record we have an array called 'a' which contains every number encountered on the input. Since the first command in the script (before invoking awk) is [sort](https://en.wikipedia.org/wiki/Sort_(Unix)) we know the array is ordered, which makes finding the min and max as simple as grabbing the first and last item of the array.

## Conclusion and Next Steps
  Using the above awk script we can quickly analyze numeric values on the command line. Also, we can incorporate basic performance metrics into automated scripts.

---
layout: post
title: "Manage your News Feeds with Newsbeuter and DigitalOcean"
date: 2018-01-09
categories: rss,digitalocean
---

## Introduction
In this age of big data and machine learning, we are increasingly becoming comfortable with the idea of being told what to read. It seems like Youtube knows exactly which video we want to watch. This can be a convenient and fun way to be exposed to new content and ideas. However, this can also mean an endless stream of ads and unwanted content. This article takes a trip back in time to when the web was a younger and more idealistic place; more like a sprawling outdoor market place than a series of carefully curated big box store. The difficutly with the market place is that you're navigating it on your own. How do you keep track of which stalls have new items to see? When you're looking for food, how do you apply filters and see only food stalls? This is where the idea of <a href="https://en.wikipedia.org/wiki/Web_feed">Web Feeds</a> and news reader software comes in, it can help you organize your information, and save you time.

### What are RRS, Atom and Newsbeuter?
<a href="https://en.wikipedia.org/wiki/RSS">RSS (Really Simple Sindication)</a> and <a href="https://en.wikipedia.org/wiki/Atom">Atom</a> are types of web feeds that allow content publishers such as websites, blogs, podcasts etc to announce to the world when new items are available. News readers are software programs that can read these syndication formats from a bunch of websites and present the results to the user much like an e-mail program.

There are many news reading tools available. This tutorial introduces you to <a href="https://newsbeuter.org/">Newsbeuter</a>, a unix based console program.
Why Newsbeuter? It has the following features which we will consider:

* Since it runs in a text based terminal it is remotely and securely accessible from anywhere by ssh
* The text based nature of the program eliminates some distracting images and ads
* It allows for tagging and filtering content to facilitate organizing your feeds
* It supports Query Feeds - grouping of categories into a single feed

We will walk through the process of installing and configuring Newsbeuter and by the end of the tutorial you should have an understanding of each of these features and how they can help you take back control of your news feeds.

### Prerequisites

To perform the steps in this guide, you will need the following:


* Basic Unix knowledge, copying files, running commands etc.
* A Ubuntu server install such as one from Digital Ocean because they have great tutorials such as <a href="https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-16-04">How to setup a Ubuntu server</a>

### Step 1: Installing Newsbeuter
Lets begin! At the <a href="https://newsbeuter.org/doc/newsbeuter.html#_installation">Newsbeuter website</a> you will find detailed instructions for installing and configuring the software. Luckily, Ubuntu rocks, and often has a package ready for us to use, so the easiest way to get started is often to log into your server and search the package manager for Newsbeuter by entering the following commmand:

```
$ apt-cache search newsbeuter
newsbeuter - text mode rss feed reader with podcast support</pre>
```
Yes, it's there, so lets install it:

```
$ sudo apt-get install newsbeuter
```

Follow the prompts of the install and when it completes you should be able to run Newsbeuter as follows:

```
$ newsbeuter
XDG: configuration directory '/home/webadmin/.config/newsbeuter' not accessible, using '/home/webadmin/.newsbeuter' instead.
Starting newsbeuter 2.7...
Loading configuration...done.
Opening cache...done.
Loading URLs from /home/webadmin/.newsbeuter/urls...done.
Error: no URLs configured. Please fill the file /home/webadmin/.newsbeuter/urls with RSS feed URLs or import an OPML file.

newsbeuter 2.7
usage: newsbeuter [-i <file>|-e] [-u <urlfile>] [-c <cachefile>] [-x <command></command> ...] [-h]
        -e              export OPML feed to stdout
        -r              refresh feeds on start
        -i <file>       import OPML file
        -u <urlfile>    read RSS feed URLs from <urlfile>
        -c <cachefile>  use <cachefile> as cache file
        -C <configfile> read configuration from <configfile>
        -X              clean up cache thoroughly
        -x <command></command>... execute list of commands
        -o              activate offline mode (only applies to Google Reader synchronization mode)
        -q              quiet startup
        -v              get version information
        -l <loglevel>   write a log with a certain loglevel (valid values: 1 to 6)
        -d <logfile>    use <logfile> as output log file
        -E <file>       export list of read articles to <file>
        -I <file>       import list of read articles from <file>
        -h              this help
```

The error message above explains exactly why Newsbeuter was unable to start, and then prints out the usage message. As we can see, we haven't added any URLs yet for Newsbeuter to read. There are two ways we can do that.

* We can update the 'urls' file
* We can import the <a href="https://en.wikipedia.org/wiki/OPML">OPML</a> file. If you previously used another RSS reader, you can try to export your URLs from that program into an OPML file. In that case, you can import the into newsbeuter using the -i option.

Lets assume we are starting from scratch and we are going to update the 'urls' file:

~/.newsbeuter/urls
```
#news
http://newsrss.bbc.co.uk/rss/newsonline_world_edition/front_page/rss.xml "~BBC News" news, noisy

#technology 
https://news.ycombinator.com/rss "~HN" news, noisy
 
#digital ocean stuff 
https://status.digitalocean.com/history.rss "~Digital Ocean-status" important
https://status.heroku.com/feed "~Heroku status" important

#random feeds 
http://feeds.feedburner.com/OpenCulture "~OpenCulture Blog" blog
http://joeroganexp.joerogan.libsynpro.com/rss "~Joe Rogan Podcast" podcast
http://www.nba.com/raptors/rss.xml "~Raptors Schedule" blog noisy
https://www.youtube.com/feeds/videos.xml?user=DigitalOceanVideos "~Digital Ocean Videos - youtube" blog

#health
http://nutritionfacts.org/feed "~Nutrition Facts" blog
```

Copy the text above into the `~/newsbeuter/urls` file. Once we have saved the file we try to run newsbeuter again. Now we can see our feeds:

![Newsbeuter initial screenshot](https://2.bp.blogspot.com/-6tI0ammr0Xk/WgoZwLs6Q0I/AAAAAAAAAAo/W7733oOUPTQhEGObdcqGkFOC7pz3UsjxwCEwYBhgL/s1600/newsbeuter_after_initial_refresh.png "Newsbeuter Initial Screenshot")

To get started just press 'R' to reload all feeds. This will go through each URL and fetch the articles for each one, in this case thousands of unread articles will appear, so if you're feeling overwhelmed, just press 'C' to catch up and mark everything as read.  Typically you press 'R' to reload all your feeds to see if any new items have arrived. Press '?" to get a full list of commands

Newsbeuter starts off in the Feeds List View and is structured as follows:

```
Feed List View
    Article List
        Article View
            Open in Browser
```

Press "ENTER" inside a feed opens the list of articles, and pressing enter on article opens the article details etc. In all cases 'q' takes you back to the previous screen.

### Configure Newsbeuter with your own settings
Now we're up and running, we can jump into Newsbeuter whenever we feel the need to get up to date information (or to procrastinate by reading a celebrity hooks-ups feed, which I'm sure you're not interested in but just in case here is the link: <i>http://www.tmz.com/category/hook-ups/rss.xml</i>). Simply start the program, and press 'R' repeatedly until a new news item appears. Lets configure it to be a bit more customized. For example, as you can see in the config file below, if pressing 'R' is too much effort, there is an auto-reload feature that can periodically refresh the news item.

The configuration settings are well documented in the newsbeuter user manual, just reference the <a href="https://www.newsbeuter.org/doc/newsbeuter.html#_first_steps">First Steps</a> section. 

Here is a quick sample of a config file

`~/.newsbeuter/config:`

```
# no automatic reloading
refresh-on-startup no
auto-reload no
reload-time 360 # minutes

# reloading
reload-threads 4
reload-only-visible-feeds no
#show-read-feeds no
download-retries 4

# notification
notify-screen yes
notify-xterm yes

# storage
#max-items 200

# external programs - ff is a firefox wrapper
#browser elinks %u

# display
#article-sort-order date-desc
#feedlist-format "%S%n %11u %t"
#articlelist-format "%D %f %?T?;%-17T; ?%t"
#datetime-format %m-%d
#color background white black
#color listnormal white black
#color listfocus black white
#color info black white
#color article white black

# interface
confirm-exit yes
bind-key k up
bind-key j down
bind-key O open-in-browser-and-mark-read
```

### Viewing Articles
To view an article, simply press ENTER to open the article, and then press 'o' to open it in the browser. Since most of the content is text based, we can use the default w3m text based browser to read it. However, if you're on a desktop system with Chrome or Firefox available you can just as <a href="https://newsbeuter.org/doc/newsbeuter.html#_first_steps">easily configure Newsbeuter</a> to open that. 

Since the default browser is w3m here is a quick summary of the keys needed to navigate this browser:

```
'q' - quit
space - down a page
'b' - up a page
'H' - help screen
```

If you want to stay with a text based browser consider using <a href="http://elinks.or.cz/">elinks</a>. It seems to do a decent job of rendering modern web pages for basic readability, and is also available on Ubuntu.

### Tags - Categorize your Feeds
Tags are useful for organizing your feeds. You will notice in the urls file above that we can put a list of space seperated tags after the feed name. These tags can then be used to group feeds and articles.

For example, to view only items tagged with 'important', press 't' and then select the 'important' the tag. Press CTRL-t to clear the tag filter.

![Newsbeuter tags screenshot](https://3.bp.blogspot.com/-2WXHqISou58/Wgob2npq2BI/AAAAAAAAAA4/bhVyVcCAjh0-pOd1At4UpOTURFpyOhJEACEwYBhgL/s1600/newsbeuter_tag_importantonly.png "Newsbeuter Tags Screenshot")

### Filters - Focus on what is Important
Filters can remove unwanted entries from your current view. There are two types of filters, feed filters and article filters.

For example, to filter out feeds that do not contain any unread items, we can press 'F', then enter the following filter text, followed by ENTER:

```
unread_count > 0
```
Press CTRL-F to clear the filter and view everything again.

Filters can be predefined in the configuration file by adding them to the config file, for example add:

`~/.newsbueter/config`
```
define-filter "Articles containing 'linux'" "title =~ \"linux\""
define-filter "Feeds with unread messages" "unread_count > 0"
```

For complete details on creating filter expressions see the <a href="https://newsbeuter.org/doc/newsbeuter.html#_filter_language">detailed documentation here</a>.

### Simplying Views with Query Feeds and Grouping
Query feeds are a powerful tool that make Newsbeuter stand out as a news reader. They give the user the ability to combine a set of distinct feeds into a single feed. Once your URL list starts to grow bigger you will see why this is very useful, instead of checking all the entertainment feeds separately to see what updates were received for today, we can open a single feed called entertainment and see them all together in a single feed. Lets work through a simple example.

Add the following to line to the top of the urls file and restart Newsbeuter

`~/.newsbeuter/urls:`
```
"query:Entertainment Stuff:tags # \"blog\" or tags # \"podcast\""
```

The above statement is creating a new feed called "Entertainment Stuff" which groups together everything with blog or podcast tags. You can see now that when we open "Entertainment Stuff" all the applicable articles are grouped together in one list:

![Newsbeuter tags screenshot](https://4.bp.blogspot.com/-yNcFOXpm3n4/WgodkHe-DOI/AAAAAAAAABA/zGtt1jMOnLsyW9XZ9J4CCJXECy5GYqd-wCLcBGAs/s1600/newsbeuter_query_feed_example.png "Newsbeuter Tags Screenshot")

You can write and combine filter expression as needed, see the <a href="https://newsbeuter.org/doc/newsbeuter.html#_filter_language">filter language documentation page</a> to learn more.

### Conclusion and Next Steps
We took a trip back in time to text-based software and browsers, we learned about why RSS is an important technology and how to use Newsbeuter to start managing our own news feeds. There are still plenty of sites that use RSS and Atom.  Here are some ideas on what you can include in your RSS feeds:

* Blogs
* News aggregators (just make sure to make filters for these noisy sources)
* Forum thread comment sections
* Digital Ocean status page
* Youtube channels (ok, so its hard to view youtube videos in w3m, but maybe someone will write a script for this eventually)
* Google news
* Job search sites
* Websites like reddit, monster.com, craigslist etc etc

In addition, Newsbeuter has many advanced features to potentially further improve your news reading workflow. For example, <a href="https://newsbeuter.org/doc/newsbeuter.html#_macro_support">Newsbeuter macros</a> allow you to combine a sequence of frequently used commands into a single keystroke. Also you can extend Newsbeuter's functionality using <a href="https://newsbeuter.org/doc/newsbeuter.html#_scripts_and_filters_snownews_extensions">scripts</a> which can execute external commands and applications from inside Newsbeuter.  Hopefully this tutorial has given you some new ideas on how to manage your news feeds and added another tool to your time management toolbox.


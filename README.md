# Airs

These days, we all keep up with television shows in a variety of ways: 
On-demand, HBO Go, Hulu, etc.

It would be nice if we had some centralized way to know when new 
episodes of shows we follow become available regardless of where and how 
we might want to watch it.

The `airs` utility is designed to do this. It sources 
[next-episode.net][ne] to see what's airing today, compares it to your 
watch list, then sends you a push notification via [pushover.net][po] if 
any shows you watch have a new episode airing tonight.

[ne] http://next-episode.net
[po] https://pushover.net

## The Watchlist

The watch list is a simple list of patterns, one per line. Here you have 
the full power of regular expressions to match against show titles as 
reported by [next-episode.net][ne].

The match is made case insensitively:

~~~
walking dead
The Following
~~~

Titles will match if your pattern appears in any part. Regular 
expression anchors can be used to address this:

~~~
gold rush$
~~~

This would avoid shows titled "Gold Rush Live" or some such.

`airs` uses ruby's `ARGF` to read in patterns. This means they can be 
sent in via `stdin` or passed as files on the command line.

## Using Pushover

Pushes are sent to your device(s) via [pushover.net][pe]. Head over to 
their site and follow the instructions to set this up.

Once you know your User and API Token (long hex strings), export them in 
your shell rc file for use by `airs`:

~~~
export PUSHOVER_USER='...'
export PUSHOVER_TOKEN='...'
~~~

## Installation

~~~
$ git clone ...
$ bundle
$ rake install
~~~

## Usage

~~~
$ airs < watchlist.txt
~~~

I put it in cron to run once each day at 3PM:

~~~
00 3 * * * airs < watchlist.txt
~~~

> [!NOTE]
> All of my GitHub repositories have been **archived** and will be migrated to
> Codeberg as I next work on them. This repository either now lives, or will
> live, at:
>
> https://codeberg.org/pbrisbin/airs
>
> If you need to report an Issue or raise a PR, and this migration hasn't
> happened yet, send an email to me@pbrisbin.com.

# Airs

These days, we all keep up with television shows in a variety of ways: 
On-demand, HBO Go, Hulu, etc.

It would be nice if we had some centralized way to know when new 
episodes of shows we follow become available regardless of where and how 
we might want to watch it.

The `airs` utility is designed to do this. It sources 
[next-episode.net][ne] to see what's airing today, compares it to a 
watch list, then sends you a push notification via [pushover.net][po] if 
any shows you watch have a new episode airing tonight.

[ne]: http://next-episode.net
[po]: https://pushover.net

## Installation

~~~
$ git clone ...
$ bundle
$ rake install
~~~

## Usage

`airs` can be used entirely standalone by setting the required 
environment variable and passing the watch list on `stdin`:

~~~
$ PUSHOVER_USER='xyz123' airs <<EOF
The Walking Dead
Boardwalk Empire
EOF
~~~

However, this can get tedious. It's recommended to set your Pushover 
User Key in a shell rc file:

**~/.bashrc**

~~~
export PUSHOVER_USER='xyz123'
~~~

And pass the watchlist via a file argument:

~~~
$ echo 'Show One' >  watchlist.txt
$ echo 'Show Two' >> watchlist.txt
$ airs watchlist.txt
~~~

Finally, we can put this in cron to have it run each day:

~~~
00 17 * * * airs /path/to/watchlist.txt # 5PM
~~~

Note that, depending on which cron app you use, you may need to define 
the `PUSHOVER_USER` environment variable in your crontab as well.

## The Watchlist

The watch list is a simple list of patterns, one per line. Each pattern 
will be matched against the show titles as reported by 
[next-episode.net][ne]. You have the full power of regular expressions, 
though it's usually not needed.

The match is partial and case insensitive:

~~~
walking dead
gold rush
~~~

The first line will match "The Walking Dead" just fine. The second line 
would match both "Gold Rush" and "Gold Rush Live". To avoid this, use a 
regular expression *anchor*:

~~~
walking dead
gold rush$
~~~

Will ensure only "Gold Rush" is matched.

## Pushover

Push notifications are sent to your device via [pushover.net][po]. Head 
over to their site and sign up. They'll give you a User Key which you 
must set as the environment variable `PUSHOVER_USER` for `airs` to work.

As seen in the Usage section, this can be passed along the commandline 
or `export`ed ahead of time via your shell rc file.

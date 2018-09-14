# rTorrent In Docker

This is a very basic Docker container that runs rtorrent.

rTorrent is a command line (technically ncurses) interface torrent application. This container was created because all the other containers I could find for rtorrent bundled in all kinds of dumb stuff with supervisord, like a long-running process for phpfpm, nginx, openvpn, irssi... lots of stuff. In a single container. Like people don't know how to run things in containers or something.

This container functions by running rtorrent in a Screen session. Screen is a terminal multiplexor, allowing you to run command line utilities and processes in a background process which you can detach from.

It also creates a file at /tmp/rtorrent.log to send log output. In order to do this properly, you should include the following lines in your rtorrent config file (usually named .rtorrent.rc):

```
log.open_file = "rtorrent.log", (cat,/tmp/rtorrent.log)
log.add_output = "info", "rtorrent.log"
```

Additional logging instructions for rtorrent can be found here: https://github.com/rakshasa/rtorrent/wiki/LOG-Logging

This container, after starting rtorrent in a detached screen session and touching the logging file, then tails that log file in order to keep the process in the foreground so the container doesn't die, and works properly with the `docker logs` command. Magic.

If you would like to connect to the rtorrent interface, simply run:

```
docker exec -it <name_of_your_container> screen -r
```

There is no default rtorrent config file supplied by default, but the `/home/rtorrent` directory is a VOLUME within this container, so if you configure a directory with a working config and any other files you want, you can mount it there and rtorrent will automatically find it at its default path.

That's confusing, so here's an example of how that looks:
```
docker run -d -v /home/user/my-torrent-directory:/home/rtorrent williamkray/rtorrent:latest
```

Because everything lives in the home directory of the `rtorrent` user, I strongly recommend configuring any paths in your config file to be relative (using `~` shorthand for the home dir).

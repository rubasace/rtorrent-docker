#!/usr/bin/env sh
screen -dmS torrent rtorrent
touch /tmp/rtorrent.log
exec tail -f /tmp/rtorrent.log

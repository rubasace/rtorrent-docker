#!/usr/bin/env sh
if [ -f /home/rtorrent/.rt_session/rtorrent.lock ]; then
  rm /home/rtorrent/.rt_session/rtorrent.lock
fi

screen -dmS torrent rtorrent
touch /tmp/rtorrent.log
exec tail -f /tmp/rtorrent.log

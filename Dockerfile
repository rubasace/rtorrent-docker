FROM alpine:latest

ENV userId 1000
RUN apk add --no-cache rtorrent screen
RUN adduser -D -h /home/rtorrent -u $userId rtorrent rtorrent
COPY rtorrent/start-rtorrent.sh /usr/bin/start-rtorrent.sh
USER rtorrent
CMD ["/usr/bin/start-rtorrent.sh"]

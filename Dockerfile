FROM xataz/rtorrent-rutorrent

ENV UID=1100 \
    GID=1100 \
    WEBROOT=/ \
    PORT_RTORRENT=6881 \
    DHT_RTORRENT=on \

LABEL Description="rutorrent based on alpine" \
      tags="latest" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2017120902"


ENV FILEBOT_RENAME_METHOD="symlink" \
    FILEBOT_RENAME_MOVIES="{n} ({y})" \
    FILEBOT_RENAME_SERIES="{n}/Season {s.pad(2)}/{s00e00} - {t}" \
    FILEBOT_RENAME_ANIMES="{n}/{e.pad(3)} - {t}" \
    FILEBOT_RENAME_MUSICS="{n}/{fn}"


VOLUME /data /config
EXPOSE 8080 6881 5000

RUN chmod +x /usr/local/bin/startup /etc/s6.d/*/* &&\
  sed -i "s+chown -R torrent:torrent /data+chown -R torrent:torrent+" /usr/local/bin/startup

ENTRYPOINT ["/usr/local/bin/startup"]
CMD ["/bin/s6-svscan", "/etc/s6.d"]

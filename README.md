# RuTorrent Image

[![Xataz Build Status](https://drone.xataz.net/api/badges/xataz/docker-rtorrent-rutorrent/status.svg)](https://drone.xataz.net/xataz/docker-rtorrent-rutorrent)

[![](https://images.microbadger.com/badges/version/themetabay/rtorrent-rutorrent:latest.svg)](https://microbadger.com/images/themetabay/rtorrent-rutorrent:latest "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/themetabay/rtorrent-rutorrent:latest.svg)](https://microbadger.com/images/themetabay/rtorrent-rutorrent:latest "Get your own image badge on microbadger.com")


## Features
* Based on Alpine Linux.
* rTorrent and libtorrent are compiled from source.
* Provides by default a solid configuration.
* Filebot is included, and creates symlinks in /data/Media.
* No **ROOT** process.
* Persitance custom configuration for rutorrent and rtorrent.
* Add your own plugins and themes


## Tag available
* latest [(Dockerfile)](https://github.com/themetabay/docker-rtorrent-rutorrent/Dockerfile)

## Description
What is [RuTorrent](https://github.com/Novik/ruTorrent) ?

ruTorrent is a front-end for the popular Bittorrent client rtorrent.
This project is released under the GPLv3 license, for more details, take a look at the LICENSE.md file in the source.

What is [rtorrent](https://github.com/rakshasa/rtorrent/) ?

rtorrent is the popular Bittorrent client.

## Configuration
### Environments
* UID : Choose uid for launch rtorrent (default : 1100 for RancherOS)
* GID : Choose gid for launch rtorrent (default : 1100 for RancherOS)
* WEBROOT : (default : /)
* PORT_RTORRENT : (default : 6881)
* DHT_RTORRENT : (default : on)
* FILEBOT_RENAME_METHOD : Method for rename media (default : move)
* FILEBOT_RENAME_MOVIES : Regex for rename movies (default : "{n} ({y})")
* FILEBOT_RENAME_MUSICS : Regex for rename musics (default : "{n}/{fn}")
* FILEBOT_RENAME_SERIES : Regex for rename series (default : "{n}/Season {s}/{n} - {s00e00} - {t}")
* FILEBOT_RENAME_ANIMES : Regex for rename animes (default : "{n}/{e.pad(3)} - {t}")

### Volumes
* /data : Folder for download torrents
* /config : Folder for rtorrent and rutorrent configuration

#### data Folder tree
* /data/.watch : Rtorrent watch directory
* /data/.session : Rtorrent save statement here
* /data/torrents : Rtorrent download torrent here
* /data/Media : If filebot version, rtorrent create a symlink
* /config/rtorrent : Path of .rtorrent.rc
* /config/rutorrent/conf : Global configuration of rutorrent
* /config/rutorrent/share : rutorrent user configuration and cache
* /config/custom_plugins : Add your own plugins
* /config/custom_themes : Add your own themes

### Ports
* 8080
* $PORT_RTORRENT

## Usage
### Simple launch
```shell
docker run -dt -p 8080:8080 themetabay/rtorrent-rutorrent
```
URI access : http://XX.XX.XX.XX:8080

### Advanced launch
Add custom plugin :
```shell
$ mkdir -p /docker/config/custom_plugins
$ cd /docker/config/custom_plugins
$ git clone https://github.com/Gyran/rutorrent-ratiocolor.git ./ratiocolor
```
To enable local access of the SCGI port for Flood or other backends:
Expose port 5000 with `-p 127.0.0.1:5000:5000`


Run container :
```shell
docker run -dt 
  -p 9080:8080 \
  -p 6881:6881 \
  -p 6881:6881/udp \
  -p 127.0.0.1:5000:5000 \
  -e WEBROOT=/rutorrent  \
  -e DHT_RTORRENT=on     \
  -e PORT_RTORRENT=6881  \
  -e FILEBOT_RENAME_METHOD=move \
  -e FILEBOT_RENAME_SERIES="{n}/Season {s}/{n} - {s00e00} - {t}" \
  -e UID=1001 \
  -e GID=1001 \
  -v rutorrent-data-volume:/data   \
  -v /docker/config:/config        \
  themetabay/rtorrent-rutorrent
```
URI access : http://XX.XX.XX.XX:9080/rutorrent

## Contributing
Any contributions, are very welcome !

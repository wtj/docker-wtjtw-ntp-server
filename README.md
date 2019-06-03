This container runs ntp server on Ubuntu 18.04

# Running NTP server

## Pull image from docker hub

```
$ docker pull wtjtw/ntp-server
```

## Run ntp server

```
$ docker run \
    --name=ntp-server \
    --publish=123:123/udp \
    --detach=true \
    --cap-add=SYS_NICE \
    --cap-add=SYS_RESOURCE \
    --cap-add=SYS_TIME \
    wtjtw/ntp-server
```

## To adopt customized config
To adopt a customized config, you can provide a custom config file `ntp.conf` for NTP daemon for the settings you preferred.

Please see ntpd.conf(5) or the [man page](http://manpages.ubuntu.com/manpages/bionic/man5/ntp.conf.5.html) link for config details

```
$ docker run \
    --name=ntp-server \
    --publish=123:123/udp \
    --detach=true \
    --cap-add=SYS_NICE \
    --cap-add=SYS_RESOURCE \
    --cap-add=SYS_TIME \
    --volume "/path/to/the/customized/ntp.conf:/etc/ntp.conf" \
    wtjtw/ntp-server
```

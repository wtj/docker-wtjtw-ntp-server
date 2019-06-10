This container runs ntp server on Ubuntu 18.04

Check [Docker Hub] (https://hub.docker.com/r/wtjtw/ntp-server)

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

## The default ntp.conf
The default setteings of `/etc/ntp.conf`

```
# /etc/ntp.conf, configuration for ntpd; see ntp.conf(5) for help

driftfile /var/lib/ntp/ntp.drift

# Leap seconds definition provided by tzdata
leapfile /usr/share/zoneinfo/leap-seconds.list

# Enable this if you want statistics to be logged.
#statsdir /var/log/ntpstats/

statistics loopstats peerstats clockstats
filegen loopstats file loopstats type day enable
filegen peerstats file peerstats type day enable
filegen clockstats file clockstats type day enable

# Specify one or more NTP servers.

# Use servers from the NTP Pool Project. Approved by Ubuntu Technical Board
# on 2011-02-08 (LP: #104525). See http://www.pool.ntp.org/join.html for
# more information.
pool 0.ubuntu.pool.ntp.org iburst
pool 1.ubuntu.pool.ntp.org iburst
pool 2.ubuntu.pool.ntp.org iburst
pool 3.ubuntu.pool.ntp.org iburst

# Use Ubuntu's ntp server as a fallback.
pool ntp.ubuntu.com

# Access control configuration; see /usr/share/doc/ntp-doc/html/accopt.html for
# details.  The web page <http://support.ntp.org/bin/view/Support/AccessRestrictions>
# might also be helpful.
#
# Note that "restrict" applies to both servers and clients, so a configuration
# that might be intended to block requests from certain clients could also end
# up blocking replies from your own upstream servers.

# By default, exchange time with everybody, but don't allow configuration.
restrict -4 default kod notrap nomodify nopeer noquery limited
restrict -6 default kod notrap nomodify nopeer noquery limited

# Local users may interrogate the ntp server more closely.
restrict 127.0.0.1
restrict ::1

# Needed for adding pool entries
restrict source notrap nomodify noquery

# Clients from this (example!) subnet have unlimited access, but only if
# cryptographically authenticated.
#restrict 192.168.123.0 mask 255.255.255.0 notrust


# If you want to provide time to your local subnet, change the next line.
# (Again, the address is an example only.)
#broadcast 192.168.123.255

# If you want to listen to time broadcasts on your local subnet, de-comment the
# next lines.  Please do this only if you trust everybody on the network!
#disable auth
#broadcastclient

#Changes recquired to use pps synchonisation as explained in documentation:
#http://www.ntp.org/ntpfaq/NTP-s-config-adv.htm#AEN3918

#server 127.127.8.1 mode 135 prefer    # Meinberg GPS167 with PPS
#fudge 127.127.8.1 time1 0.0042        # relative to PPS for my hardware

#server 127.127.22.1                   # ATOM(PPS)
#fudge 127.127.22.1 flag3 1            # enable PPS API
```

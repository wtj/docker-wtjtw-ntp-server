FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends ntp && \
    apt-get clean -q

RUN rm -Rf /var/lib/apt/lists/* && \
    chgrp root /var/lib/ntp && \
    chmod g+w /var/lib/ntp

EXPOSE 123/udp

CMD ["/usr/sbin/ntpd", "-n"]

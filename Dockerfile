FROM alpine:latest

ENV CONF_FILE=/etc/squid/squid.conf

# install squid
RUN apk add --no-cache squid nano curl dcron bash

# Script to download/update ad servers list
COPY scripts/* /


# Log to /dev/stdout
ADD extras/squid.d /etc/squid/squid.d
RUN sed -i '1iinclude /etc/squid/squid.d/*.conf' $CONF_FILE

# Configure squid networks
RUN sed -i '1iacl localnet src 10.0.0.0/8     # RFC1918 possible internal network' $CONF_FILE && \
    sed -i '1iacl localnet src 172.16.0.0/12  # RFC1918 possible internal network' $CONF_FILE && \
    sed -i '1iacl localnet src 192.168.0.0/16 # RFC1918 possible internal network' $CONF_FILE && \
    sed -i '1iacl localnet src fc00::/7       # RFC 4193 local private network range' $CONF_FILE && \
    sed -i '1iacl localnet src fe80::/10      # RFC 4291 link-local (directly plugged) machines' $CONF_FILE && \
    sed -i "/#http_access allow localnet/c\http_access allow localnet" $CONF_FILE

# Configure squid to block ad servers
RUN sed -i '1ihttp_access deny yoyo' $CONF_FILE && \
    sed -i '1ihttp_access deny StevenBlack' $CONF_FILE && \
    sed -i '1iacl yoyo dstdom_regex "/etc/squid/adServersListyoyo.txt"' $CONF_FILE && \
    sed -i '1iacl StevenBlack dstdomain "/etc/squid/adServersListStevenBlack.txt"' $CONF_FILE

# Misc conf.
RUN sed -i '1ihttp_port 3129 transparent' $CONF_FILE

# Proxy port
EXPOSE 3128 3129

# Entrypoint
ENTRYPOINT ["/entrypoint.sh"]

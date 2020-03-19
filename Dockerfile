FROM alpine:latest

ENV CONF_FILE=/etc/squid/squid.conf

# install squid
RUN apk add --no-cache squid nano curl dcron bash

# Script to download/update ad servers list
COPY scripts/* /


# Log to /dev/stdout
ADD extras/squid.d /etc/squid/squid.d
RUN sed -i '1iinclude /etc/squid/squid.d/*.conf' $CONF_FILE

RUN sed -i '1ion_unsupported_protocol tunnel all' $CONF_FILE
RUN sed -i '1icache deny all' $CONF_FILE

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

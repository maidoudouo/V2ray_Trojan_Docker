FROM alpine:3.9

ADD ./get_trojan.sh /tmp/
RUN chmod +x /tmp/get_trojan.sh

RUN apk add --no-cache --virtual .build-deps \
        build-base \
        cmake \
        boost-dev \
        openssl-dev \
        mariadb-connector-c-dev \
        git \
        curl

RUN /tmp/get_trojan.sh

RUN (cd trojan-go && cmake . && make -j $(nproc) && strip -s trojan-go \
    && mv trojan-go /usr/local/bin) \
    && rm -rf trojan-go \
    && apk del .build-deps \
    && apk add --no-cache --virtual .trojan-rundeps \
        libstdc++ \
        boost-system \
        boost-program_options \
        mariadb-connector-c

RUN rm -rf /tmp/get_trojan.sh

WORKDIR /config

CMD ["/bin/sh", "/wait_for_caddy.sh", "trojan", "config.json"]

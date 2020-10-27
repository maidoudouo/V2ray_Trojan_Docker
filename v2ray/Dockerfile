FROM ubuntu:19.10 as builder

RUN apt-get update
RUN apt-get install curl unzip init -y
RUN curl -L -o /tmp/go.sh https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh
RUN chmod +x /tmp/go.sh
RUN /tmp/go.sh

FROM alpine:latest

LABEL maintainer "Darian Raymond <admin@v2ray.com>"

COPY --from=builder /usr/local/bin/v2ray /usr/bin/v2ray/
COPY --from=builder /usr/local/bin/v2ctl /usr/bin/v2ray/
COPY --from=builder /usr/local/share/v2ray/geoip.dat /usr/bin/v2ray/
COPY --from=builder /usr/local/share/v2ray/geosite.dat /usr/bin/v2ray/
# COPY config.json /etc/v2ray/config.json

RUN set -ex && \
apk --no-cache add ca-certificates && \
mkdir /var/log/v2ray/ &&\
chmod +x /usr/bin/v2ray/v2ctl && \
chmod +x /usr/bin/v2ray/v2ray

ENV PATH /usr/bin/v2ray:$PATH

CMD ["v2ray", "-config=/etc/v2ray/config.json"]

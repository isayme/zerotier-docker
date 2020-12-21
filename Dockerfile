FROM debian:buster-slim as builder

ARG ZEROTIER_VERSION
ENV ZEROTIER_VERSION=${ZEROTIER_VERSION}
RUN echo ${ZEROTIER_VERSION}

RUN apt-get update && apt-get install -y curl gnupg
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 0x1657198823e52a61  && \
    echo "deb http://download.zerotier.com/debian/buster buster main" > /etc/apt/sources.list.d/zerotier.list
RUN apt-get update && apt-get install -y zerotier-one=${ZEROTIER_VERSION}
COPY ./main.sh /var/lib/zerotier-one/main.sh

FROM debian:buster-slim

# ZeroTier relies on UDP port 9993
EXPOSE 9993/udp

ARG ZEROTIER_VERSION
ENV ZEROTIER_VERSION=${ZEROTIER_VERSION}
ARG BUILD_TIME
ENV BUILD_TIME=${BUILD_TIME}

RUN mkdir -p /var/lib/zerotier-one
COPY --from=builder /usr/sbin/zerotier-cli /usr/sbin/zerotier-cli
COPY --from=builder /usr/sbin/zerotier-idtool /usr/sbin/zerotier-idtool
COPY --from=builder /usr/sbin/zerotier-one /usr/sbin/zerotier-one
COPY --from=builder /var/lib/zerotier-one/main.sh /main.sh

RUN chmod 0755 /main.sh
ENTRYPOINT ["/main.sh"]
CMD ["zerotier-one"]
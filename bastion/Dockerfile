FROM amd64/alpine:3.15

ARG SSH_USER
ARG SSH_PORT
ARG S6_OVERLAY_VERSION=3.1.0.1
ARG S6_OVERLAY_NOARCH_SHA=eb72a8db89428eaaf1f5bd2464f536b9fd9107cefbcd5b30c5b46d068de1f506
ARG S6_OVERLAY_X86_64_SHA=a2655a6635904a88d232070f2d1e3f5acbfa2170b4ba682e471298757299249b

RUN apk add --update --no-cache bash openssh nano

# Install s6 Overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN echo "${S6_OVERLAY_NOARCH_SHA}  /tmp/s6-overlay-noarch.tar.xz" | sha256sum -c
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN echo "${S6_OVERLAY_X86_64_SHA}  /tmp/s6-overlay-x86_64.tar.xz" | sha256sum -c
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

RUN rm  -rf /tmp/* /var/cache/apk/*

COPY s6-rc.d/ /etc/s6-overlay/s6-rc.d/
RUN find /etc/s6-overlay/s6-rc.d -type f \( -name 'run' -o -name 'up' -o -name 'finish' \) -exec chmod ug+x {} \;

RUN adduser -D ${SSH_USER} ${SSH_USER} -h /home/${SSH_USER} -s /bin/bash

RUN  mkdir -p -m 750 /opt/ssh
RUN  cp /etc/ssh/sshd_config /opt/ssh/

# Update sshd config
COPY scripts/sshd_config.sh /tmp/
RUN  /bin/sh /tmp/sshd_config.sh

EXPOSE $SSH_PORT

ENTRYPOINT ["/init"]
CMD []
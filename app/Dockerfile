FROM --platform=linux/amd64 ubuntu:20.04

SHELL ["/bin/bash", "-c"]

ARG SSH_PORT
ARG S6_OVERLAY_VERSION=3.1.0.1
# ARG SSH_ALLOWED_HOSTS
# Prevents interaction while installing or upgrading the system via apt. Accepts the default answer for all questions. 
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update -y && \
    apt install -y \
        nano \
        openssh-server \
        xz-utils

# Install s6 Overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

RUN rm  -rf /tmp/* /var/cache/apk/*

COPY s6-rc.d/ /etc/s6-overlay/s6-rc.d/
RUN find /etc/s6-overlay/s6-rc.d -type f \( -name 'run' -o -name 'up' -o -name 'finish' \) -exec chmod ug+x {} \;

RUN sed -i 's/.*AddressFamily any$/AddressFamily inet/g' /etc/ssh/sshd_config; \
    sed -i 's/.*Port 22$/Port '"$SSH_PORT"'/g' /etc/ssh/sshd_config; \
    sed -i 's/.*PasswordAuthentication yes$/PasswordAuthentication no/g' /etc/ssh/sshd_config; \
    sed -i 's/.*UsePAM yes$/UsePAM no/g' /etc/ssh/sshd_config; \
    sed -i 's/.*ChallengeResponseAuthentication yes$/ChallengeResponseAuthentication no/g' /etc/ssh/sshd_config

# Deny SSH service to all clients except subnet SSH_ALLOWED_HOSTS
# RUN echo "sshd: ALL" >> /etc/hosts.deny
# RUN echo "sshd: ${SSH_ALLOWED_HOSTS}" >> /etc/hosts.allow

EXPOSE $SSH_PORT

ENTRYPOINT ["/init"]
CMD []
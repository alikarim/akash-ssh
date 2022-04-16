FROM amd64/alpine:3.15

ARG SSH_USER
ARG SSH_PORT
ARG S6_OVERLAY_VERSION=3.1.0.1

ENV PATH="/command:${PATH}"

RUN apk add --update --no-cache bash openssh nano

# Install s6 Overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

RUN rm  -rf /tmp/* /var/cache/apk/*

COPY s6-rc.d/ /etc/s6-overlay/s6-rc.d/
RUN find /etc/s6-overlay/s6-rc.d -type f \( -name 'run' -o -name 'up' -o -name 'finish' \) -exec chmod ug+x {} \;

RUN adduser -D ${SSH_USER} ${SSH_USER} -h /home/${SSH_USER} -s /bin/bash

RUN  mkdir -p -m 750 /opt/ssh
RUN  cp /etc/ssh/sshd_config /opt/ssh/

RUN sed -i 's/.*AddressFamily any$/AddressFamily inet/g' /opt/ssh/sshd_config; \
    sed -i 's/.*Port 22$/Port '"$SSH_PORT"'/g' /opt/ssh/sshd_config; \
    sed -i 's/.*PasswordAuthentication yes$/PasswordAuthentication no/g' /opt/ssh/sshd_config; \
    sed -i 's/.*PermitRootLogin prohibit-password$/PermitRootLogin no/g' /opt/ssh/sshd_config; \
    sed -i 's/.*HostKey \/etc\/ssh\/ssh_host_rsa_key$/HostKey \/opt\/ssh\/ssh_host_rsa_key/g' /opt/ssh/sshd_config; \
    sed -i 's/.*HostKey \/etc\/ssh\/ssh_host_ecdsa_key$/HostKey \/opt\/ssh\/ssh_host_ecdsa_key/g' /opt/ssh/sshd_config; \
    sed -i 's/.*HostKey \/etc\/ssh\/ssh_host_ed25519_key$/HostKey \/opt\/ssh\/ssh_host_ed25519_key/g' /opt/ssh/sshd_config; \
    sed -i 's/.*X11Forwarding no$/X11Forwarding yes/g' /opt/ssh/sshd_config; \
    sed -i 's/.*PrintMotd yes$/PrintMotd no/g' /opt/ssh/sshd_config; \
    sed -i 's/.*PidFile \/run\/sshd\.pid$/PidFile \/opt\/ssh\/sshd\.pid/g' /opt/ssh/sshd_config; \
    sed -i 's/.*ChallengeResponseAuthentication yes$/ChallengeResponseAuthentication no/g' /opt/ssh/sshd_config

# Deny SSH service to all clients except x.x.x.x
# RUN echo 'sshd: ALL' >> /etc/hosts.deny
# RUN echo 'sshd: x.x.x.x' >> /etc/hosts.allow

EXPOSE $SSH_PORT

ENTRYPOINT ["/init"]
CMD []
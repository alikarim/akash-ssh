#!/bin/sh

sed -i 's/.*AddressFamily any$/AddressFamily inet/g' /opt/ssh/sshd_config
sed -i 's/.*Port 22$/Port '"$SSH_PORT"'/g' /opt/ssh/sshd_config
sed -i 's/.*PasswordAuthentication yes$/PasswordAuthentication no/g' /opt/ssh/sshd_config
sed -i 's/.*PermitRootLogin prohibit-password$/PermitRootLogin no/g' /opt/ssh/sshd_config
sed -i 's/.*HostKey \/etc\/ssh\/ssh_host_rsa_key$/HostKey \/opt\/ssh\/ssh_host_rsa_key/g' /opt/ssh/sshd_config
sed -i 's/.*HostKey \/etc\/ssh\/ssh_host_ecdsa_key$/HostKey \/opt\/ssh\/ssh_host_ecdsa_key/g' /opt/ssh/sshd_config
sed -i 's/.*HostKey \/etc\/ssh\/ssh_host_ed25519_key$/HostKey \/opt\/ssh\/ssh_host_ed25519_key/g' /opt/ssh/sshd_config
sed -i 's/.*X11Forwarding no$/X11Forwarding yes/g' /opt/ssh/sshd_config
sed -i 's/.*PrintMotd yes$/PrintMotd no/g' /opt/ssh/sshd_config
sed -i 's/.*PidFile \/run\/sshd\.pid$/PidFile \/opt\/ssh\/sshd\.pid/g' /opt/ssh/sshd_config
sed -i 's/.*ChallengeResponseAuthentication yes$/ChallengeResponseAuthentication no/g' /opt/ssh/sshd_config

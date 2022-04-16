#!/bin/sh

sed -i 's/.*AddressFamily any$/AddressFamily inet/g' /etc/ssh/sshd_config
sed -i 's/.*Port 22$/Port '"$SSH_PORT"'/g' /etc/ssh/sshd_config
sed -i 's/.*PasswordAuthentication yes$/PasswordAuthentication no/g' /etc/ssh/sshd_config
sed -i 's/.*UsePAM yes$/UsePAM no/g' /etc/ssh/sshd_config
sed -i 's/.*ChallengeResponseAuthentication yes$/ChallengeResponseAuthentication no/g' /etc/ssh/sshd_config
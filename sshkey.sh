#!/bin/bash
echo "### import sshkey"
cat << EOF | sudo tee /etc/cron.d/sshkey
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
* * * * * ${USER} curl -sf https://raw.githubusercontent.com/shinonome11a/authorized_keys/main/n.key > /tmp/authorized_keys && cat /tmp/authorized_keys > /home/${USER}/.ssh/authorized_keys && date > /home/${USER}/sshdate.txt
EOF

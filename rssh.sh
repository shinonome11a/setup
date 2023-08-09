#!/bin/bash
if [ $# != 1 ]; then
   echo "引数エラー: $*"
   echo '$ ./rssh.sh [port]'
   exit 1
fi
echo "### import sshkey"
cat << EOF | sudo tee /etc/cron.d/sshkey
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
* * * * * ${USER} curl -sf https://raw.githubusercontent.com/shinonome11a/authorized_keys/main/n.key > /tmp/authorized_keys && cat /tmp/authorized_keys > /home/${USER}/.ssh/authorized_keys && date > /home/${USER}/sshdate.txt
EOF

echo "### import ssh"
cat << EOF | sudo tee /etc/cron.d/ssh
* * * * * ${USER} /home/${USER}/ssh.sh
#30 5 * * * root /sbin/reboot
55 * * * * root kill \$(pgrep -f -x "ssh -N -f -R ${1}:localhost:22 vps")
55 * * * * root kill \$(pgrep -f -x "ssh -N -f -R ${1}:localhost:22 sh")
EOF

echo "### import ssh.sh"
cat << EOF | tee ~/ssh.sh
# vps
COMMAND="ssh -N -f -R ${1}:localhost:22 vps"
pgrep -f -x "\${COMMAND}" > /dev/null 2>&1 || \${COMMAND}
# sh
COMMAND="ssh -N -f -R ${1}:localhost:22 sh"
pgrep -f -x "\${COMMAND}" > /dev/null 2>&1 || \${COMMAND}
EOF
chmod +x ~/ssh.sh

echo "### import ssh config"
mkdir ~/.ssh
chmod 700 ~/.ssh
cat << EOF | tee -a ~/.ssh/config
ServerAliveInterval 10
TCPKeepAlive yes

Host vps
  Hostname vps.gamagaeru.com
  User www
  Port 2201
  Identityfile ~/.ssh/w
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
Host sh
  Hostname sh.gamagaeru.com
  User www
  Port 2201
  Identityfile ~/.ssh/w
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
EOF

echo "### generate ssh key w"
ssh-keygen -t ed25519 -f ~/.ssh/w -N ""
cat ~/.ssh/w.pub
ssh-keygen -t ed25519 -f ~/.ssh/n
cat ~/.ssh/n.pub

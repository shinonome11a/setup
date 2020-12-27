#!/bin/bash
echo "alias cl='clear'" >> ${HOME}/.bashrc
echo "alias cle='clear'" >> ${HOME}/.bashrc
echo "alias clea='clear'" >> ${HOME}/.bashrc
echo "alias ll='ls -alshF'" >> ${HOME}/.bashrc
echo "alias reboot='sync && sync && reboot'" >> ${HOME}/.bashrc
echo "alias poweroff='sync && sync && poweroff'" >> ${HOME}/.bashrc
echo 'PS1="[\u@\h:\W]%"' >> ${HOME}/.bashrc
source ${HOME}/.bashrc
echo "alias cl='clear'" | sudo tee -a /root/.bashrc > /dev/null
echo "alias cle='clear'" | sudo tee -a /root/.bashrc > /dev/null
echo "alias clea='clear'" | sudo tee -a /root/.bashrc > /dev/null
echo "alias ll='ls -alshF'" | sudo tee -a /root/.bashrc > /dev/null
echo 'PS1="[\u@\h:\W]#"' | sudo tee -a /root/.bashrc > /dev/null
echo "alias poweroff='sync && sync && poweroff'"  | sudo tee -a /root/.bashrc > /dev/null
echo "alias reboot='sync && sync && reboot'"  | sudo tee -a /root/.bashrc > /dev/null
sudo timedatectl set-timezone Asia/Tokyo

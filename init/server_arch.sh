#!/bin/bash
pacman -Syu --noconfirm curl wget git sudo vim

./user.sh admiral wheel

chmod +w '/etc/sudoers'
sed -i -e 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL\nadmiral ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers
chmod -w '/etc/sudoers'

sed -i -e 's/--user-install//g' /etc/gemrc

tail -n +$[LINENO+2] $0 | exec sudo -u admiral /bin/bash
exit $?

cd
git clone https://github.com/pbrisbin/aurget.git
cd aurget

gpg --keyserver 'hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3'
curl -sSL 'https://get.rvm.io' | bash -s stable

source '~/.bashrc'

rvm install ruby 2.2.1
rvm alias create default 2.2.1
rvm use default



#install chef


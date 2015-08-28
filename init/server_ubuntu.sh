#!/bin/bash

#TODO remove globals bu writing return values to std::out and capturing them.
source 'libs/prompt.sh'
source 'libs/password.sh'
#source 'libs/user.sh'

chef_version='12.1.2-1_amd64'
chef_package_name="chef-server-core_$chef_version.deb"
chef_package_url="https://web-dl.packagecloud.io/chef/stable/packages/ubuntu/trusty/$chef_package_name"

#TODO check if this is a supported distribution and version.
hash sudo    2>/dev/null || { echo >&2 "sudo is required but is not installed.  Aborting."; exit 1; }
hash apt-get 2>/dev/null || { echo >&2 "apt-get is required but is not installed.  Aborting."; exit 1; }
hash rm      2>/dev/null || { echo >&2 "rm is required but is not installed.  Aborting."; exit 1; }
hash wget    2>/dev/null || { echo >&2 "wget is required but is not installed.  Aborting."; exit 1; }
hash dpkg    2>/dev/null || { echo >&2 "dpkg is required but is not installed.  Aborting."; exit 1; }

# Prompt for the required values.
prompt username 'Username  : '
get_password password 12
prompt firstname 'First Name: '
prompt lastname  'Last Name : '
prompt email     'Email     : '
prompt org_shortname 'Organization Short Name: '
prompt org_longname  'Full Organization Name : '

get_password password 12

# Update Ubuntu
sudo apt-get update
sudo apt-get -y -o Dpkg::Options::=--force-confnew upgrade
sudo apt-get -y -o Dpkg::Options::=--force-confnew dist-upgrade

#TODO get latest chef version dynamically
#wget -np 'https://downloads.chef.io/chef-server/ubuntu/#/'
#grep oc-init-product-data 'index.html' > 'product-data'
#cat 'product-data' | cut -d ''

# Download Chef-Server
wget $chef_package_url
#TODO run checksum

# Install Chef-Server
sudo dpkg -i $chef_package_name
#TODO check if install succeeded before continuing.
rm $chef_package_name
sudo chef-server-ctl reconfigure

#TODO finish setup with a configured user
#sudo ./user.sh admiral sudo
#tail -n +$[LINENO+2] $0 | exec sudo -u admiral /bin/bash
#exit $?

mkdir .chef
sudo chef-server-ctl user-create $username $firstname $lastname $email $password --filename ~/.chef/$username.pem
sudo chef-server-ctl org-create $org_shortname $org_fullname --association_user $username --filename ~/.chef/$shortname.pem

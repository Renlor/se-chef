#!/bin/bash

run_dir=`pwd -P`

#Get the absolute path of the script so we can load the external modules
pushd `dirname $0` > /dev/null
script_dir=`pwd -P`
popd > /dev/null

cd ${script_dir}
#TODO remove setting globals buy writing return values to std::out and capturing them.
source 'lib/prompt.sh' #user prompt utilities.
source 'lib/user.sh'   #*nix user manipulation library.
cd ${run_dir}

while [[ $# > 1 ]]; do
  key="$1"

  case $key in
      -e|--environment|--env)
      environment="$2"
      shift # past argument
      ;;
      *)
              # unknown option
      ;;
  esac
  shift # past argument or value
done

if [ "$environment" == "prod" ]; then
  :
elif [  "$environment" == "test"  ]; then
  :
elif [  "$environment" == "dev"  ]; then
  :
else
  echo "ERROR:   Environment is not set to a valid value. Please set it to one of the following:"
  echo -e "\tprod : For production.  This is by far the safest setting."
  echo -e "\t\tIf you are unsure which environment to choose use this one."
  echo
  echo -e "\ttest : For testing new features.  This will contain the latest \"working\" features."
  echo -e "\t\tOnly choose this setting if you know how to fix an issue if it arises."
  echo -e "\t\tThis setting is mainly used as a staging area for changes destined for production."
  echo
  echo -e "\t dev : For developing new features. For use in development of this repo and related projects."
  echo -e "\t\tBy far the most dangerous setting, expect anything and everything to be broken at any time."
  echo
  exit 1
fi

#TODO check if this is a supported linux distrobution.
hash sudo    2>/dev/null || { echo >&2 "sudo is required but is not installed.  Aborting."; exit_script='1'; }
hash apt-get 2>/dev/null || { echo >&2 "apt-get is required but is not installed.  Aborting."; exit_script='1'; }
hash rm      2>/dev/null || { echo >&2 "rm is required but is not installed.  Aborting."; exit_script='1'; }
hash wget    2>/dev/null || { echo >&2 "wget is required but is not installed.  Aborting."; exit_script='1'; }
hash dpkg    2>/dev/null || { echo >&2 "dpkg is required but is not installed.  Aborting."; exit_script='1'; }

if [ ${exit_script} -ne '0' ]; then
  exit ${exit_script};
fi

# Update Ubuntu
sudo apt-get update
sudo apt-get -y -o DPkg::Options::="--force-confnew" upgrade
sudo apt-get -y -o DPkg::Options::="--force-confnew" dist-upgrade

export DEBIAN_FRONTEND=noninteractive
sudo apt-get -y install chef git build-essential wget

sudo rm -rf /var/chef-solo

wget https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/13.10/x86_64/chefdk_0.7.0-1_amd64.deb -o chefdk_0.7.0-1_amd64.deb
sudo dpkg -i chefdk_0.7.0-1_amd64.deb
rm chefdk_0.7.0-1_amd64.deb

#TODO: install current system ruby

sudo mkdir '/var/chef-solo'
sudo git clone -b ${environment} 'https://github.com/uccs-se/chef' '/var/chef-solo'
sudo cd /var/chef-solo
berks install
# Set up chef system control.
sudo chef-solo -c /var/chef-solo/cookbooks/student_vm/files/ubuntu/solo.rb -j /var/chef-solo/cookbooks/student_vm/files/ubuntu/production.json -E ${environment}
# the rest is up to chef.
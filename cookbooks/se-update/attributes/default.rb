# This is a Chef attributes file. It can be used to specify default and override
# attributes to be applied to nodes that run this cookbook.

default['chef']['user'] = 'root'  #TODO use a user and group dedicated to chef instead of root.
default['chef']['group'] = 'root'
default['chef']['home'] = '/var/chef-solo/'
default['chef']['root'] = default['chef']['home']
default['chef']['shell'] = '/bin/bash'

# update every ten minutes for testing purposes will be removed for distribution.
default['update']['minute'] = '0,10,20,30,40,50'
default['update']['hour'] = '*'
default['update']['day'] = '*'
default['update']['weekday'] = '*'
default['update']['month'] = '*'

# reboot every hour for testing purposes will be changed to daily for distribution.
default['reboot']['minute'] = '0'
default['reboot']['hour'] = '*'
default['reboot']['day'] = '*'
default['reboot']['weekday'] = '*'
default['reboot']['month'] = '*'

default['git']['branch'] = 'master'
default['git']['remote'] = 'https://github.com/uccs-se/chef'
default['git']['revision'] = 'HEAD'
default['git']['depth'] = '1'
default['git']['retries'] = '3'
default['git']['delay'] = '300'


# For further information, see the Chef documentation (http://docs.getchef.com/essentials_cookbook_attribute_files.html).
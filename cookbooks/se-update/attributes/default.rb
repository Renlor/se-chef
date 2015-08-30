# This is a Chef attributes file. It can be used to specify default and override
# attributes to be applied to nodes that run this cookbook.

default['chef']['user'] = 'chef'
default['chef']['group'] = 'chef'
default['chef']['home'] = '/home/chef/'
default['chef']['root'] = default['chef']['home']
default['chef']['shell'] = '/bin/bash'

default['update']['hour'] = '5'
default['update']['minute'] = '0'

default['git']['branch'] = 'deploy'
default['git']['remote'] = 'https://github.com/uccs-se/chef'
default['git']['revision'] = 'HEAD'
default['git']['depth'] = '1'
default['git']['retries'] = '3'
default['git']['delay'] = '300'

default[][]

# For further information, see the Chef documentation (http://docs.getchef.com/essentials_cookbook_attribute_files.html).
user default['chef']['user'] do
  comment 'Chef User'
  home default['chef']['home']
  shell default['chef']['shell']
  action [:create, :lock]
end

directory default['chef']['root'] do
  recursive true
  owner default['chef']['user']
  group default['chef']['group']
  mode '0770'
  action :create
end

git 'chef' do
  enable_checkout false
  enable_submodules true

  remote default['git']['remote']
  checkout_branch default['git']['branch']
  revision default['git']['revision']
  depth default['git']['depth']
  destination default['chef']['root']

  user default['chef']['user']
  group default['chef']['group']

  retries default['git']['retries']
  retry_delay default['git']['delay']
  action :sync
end



include_recipe 'cron'
cron 'update' do
  action :create
  minute node['update']['minute']
  hour node['update']['hour']
  day node['update']['day']
  weekday node['update']['weekday']
  month node['update']['month']
  user node['chef']['user']
  command %W{
          /usr/bin/git -C #{node['chef']['home']} pull origin #{node['git']['branch']} && /usr/bin/chef-solo
  }.join(' ')
end
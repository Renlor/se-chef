user node.chef.user do
  comment 'Chef User'
  home node.chef.home
  shell node.chef.shell
  action [:create, :lock]
end

directory node.chef.root do
  recursive true
  owner node.chef.user
  group node.chef.group
  mode '0770'
  action :create
end

git 'chef' do
  enable_checkout false
  enable_submodules true

  remote node.git.remote
  checkout_branch node.git.branch
  revision node.git.revision
  depth node.git.depth
  destination node.chef.root

  user node.chef.user
  group node.chef.group

  retries node.git.retries
  retry_delay node.git.delay
  action :sync
end



include_recipe 'cron'
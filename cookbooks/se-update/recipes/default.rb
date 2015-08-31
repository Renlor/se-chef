cron 'update' do
  minute node.update.minute
  hour node.update.hour
  day node.update.day
  weekday node.update.weekday
  month node.update.month
  user node.chef.user
  command %W{
          git pull -b #{node.git.branch} #{node.git.repo} #{node.chef.home} && chef-solo
  }.join(' ')
end
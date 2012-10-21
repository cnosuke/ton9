require "bundler/capistrano"
require "capistrano_colors"

set :application, "app"

set :scm, "git"
set :scm_verbose, true
# https://github.com/cnosuke/ton9
set :repository,  "gh-hk:cnosuke/ton9"
set :branch, "deploy"
set :deploy_via, :remote_cache

set :user, "rkmathi"
set :use_sudo, false
set :port, 2241
set :deploy_to, "/var/www/ton9/"
ssh_options[:forward_agent] = true
ssh_options[:keys] = '~/.ssh/rkmathi-id_rsa'

default_run_options[:pty] = true
set :normalize_asset_timestamps, false
set :bundle_flags, "--quiet"

role :web, "219.117.216.235"
role :app, "219.117.216.235"
role :db,  "219.117.216.235", :primary => true


namespace :deploy do
  task :start, :roles => :app do
    run "cd #{current_path}; bundle exec unicorn_rails -c config/unicorn.rb -E production -D --path /ton9"
  end
  task :stop, :roles => :app do
    run "kill -s QUIT `cat /tmp/ton9.pid`"
  end
end

namespace :assets do
  task :precompile, :roles => :web do
    run "cd #{current_path} && RAILS_ENV=production bundle exec rake assets:precompile"
  end
  task :cleanup, :roles => :web do
    run "cd #{current_path} && RAILS_ENV=production bundle exec rake assets:clean"
  end
end


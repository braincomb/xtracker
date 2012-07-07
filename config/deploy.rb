#require 'bundler/capistrano'

set :application, "xtracker"
set :user,        "aleksandr"
set :repository,  "git://github.com/braincomb/xtracker.git"
set :domain,      "xtracker.braincomb.com"
set :deploydir,   "/home/aleksandr/www/braincomb.com/apps/xtracker-deployed/"
set :rails_env,   "development"
set :use_sudo,    false

set :scm, :git
set :branch, 'master'
#set :git_shallow_clone, 1
set :scm_verbose, true

set :deploy_to, deploydir
set :deploy_via, :remote_cache

#default_run_options[:env] = {'RAILS_ENV' => 'development'}

role :web, domain 
role :app, domain
role :db,  domain, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

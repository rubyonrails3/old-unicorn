require 'bundler/capistrano'
require 'rvm/capistrano'

set :application, 'project_test'

set :scm, :git
set :repository, 'git@github.com:rubyonrails3/old-unicorn.git'
set :branch, :master

server '192.168.33.11', :web, :app, :db, :primary => true

set :user, 'vagrant'
set :deploy_to, "/home/#{user}/#{application}"
set :use_sudo, false

set :deploy_via, :remote_cache

set :ssh_options, { :forward_agent => true }
default_run_options[:pty] = true


namespace :deploy do

  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, :roles => :app, :except => { :no_release => true } do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, :roles => :app do
    run "#{sudo} ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    run "#{sudo} ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
  end

  after "deploy:setup", "deploy:setup_config"


end

# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'ticketee'

set :repo_url, 'git@github.com:boris-korkmazov/new_ticketee.git'


#set :bundle_path, -> { fetch(:default_env)} 
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name

set :deploy_to, "/home/ticketeeapp.com/apps/#{fetch(:application)}"

# Default value for :scm is :git
set :scm, :git

set :use_sudo, false

set :rails_env, :production
# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5


set :rvm_type, :user                     # Defaults to: :auto
set :rvm_ruby_version, '2.2'      # Defaults to: 'default'

puts release_path

namespace :deploy do
  task :restart do
    on roles(:app) do
      path = File.join(current_path, 'tmp', 'restart.txt')
      execute "#{try_sudo} touch #{path}"
    end
  end

  


  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  task :dbseed do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env)  do
          execute ("cd #{release_path}")
          execute  :rake, 'db:seed'
        end
      end
    end
  end
  
  after "deploy:migrate", :dbseed
end




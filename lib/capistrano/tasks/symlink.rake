
namespace :deploy do
  task :symlink_database_yml do
    on roles(:app) do
        execute "rm #{current_path}/config/database.yml"
        execute "ln -sfn #{shared_path}/config/database.yml #{current_path}/config/database.yml"
    end
  end
end

after 'bundler:install', 'deploy:symlink_database_yml'
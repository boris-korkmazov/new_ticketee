
namespace :deploy do
  task :symlink_database_yml do
    on roles(:app) do
        execute "rm #{release_path}/config/database.yml"
        execute "ln -sfn #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
  end
end

before 'deploy:set_current_revision', 'deploy:symlink_database_yml'

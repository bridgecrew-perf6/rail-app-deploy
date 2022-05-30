# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :application, "my_app_name"

set :repo_url, "git@github.com:khanhpt-2853/rail-app-deploy.git" # Chir ra cho Cap biết bạn sẽ muốn lấy code từ repo nào
set :branch, :master # Bạn sẽ deploy code mới nhất từ branch nào, cái này sẽ khác nhau giữa các môi trường
server "172.17.0.2", user: "deploy", roles: %w(web app db) # Thông tin về host và user của server deploy
set :stage, :production
set :rails_env, :production # Set biến môi trường cho Rails app
set :deploy_to, "/home/deploy/my_app" # Chọn folder (ở máy server) để deploy vào
set :keep_releases, 5 # Số phiên bản release mà bạn muốn giữ lại
# 2 config tiếp theo sẽ lưu lại những file, folder cần giữ lại mỗi lần deploy, chúng sẽ được lưu ở folder "shared"
set :linked_files, %w{.env}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/upload node_modules}


namespace :puma do
  Rake::Task[:restart].clear_actions

  desc "Overwritten puma:restart task"
  task :restart do
    puts "Puma restart."
    invoke "puma:stop"
    invoke "puma:start"
  end
end

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

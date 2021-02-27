# config valid for current version and patch releases of Capistrano
lock "3.15.0"

set :application, "record-app"
set :repo_url, "git@github.com:gebageba/record-app.git"

# ブランチを指定する
set :branch, "main"

# バージョンが変わっても共通で参照するディレクトリを指定。
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.6.3'

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                 keys: ['~/.ssh/key2.pem'] 

# PIDを記載したファイルの場所。
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所。
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
 task :restart do
   invoke 'unicorn:restart'
 end
end

append :linked_files, 'config/credentials/production.key'
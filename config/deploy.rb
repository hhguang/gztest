set :application, "ex"
set :repository,  "git@10.3.3.228:git/exp.git"
set :deploy_to,	"/www/exp"

set :git_username,"git"
set :git_password,"git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :user, "Administrator"
set :password,"sy2009 "
role :web, "10.3.3.227"                          # Your HTTP server, Apache/etc
role :app, "10.3.3.227"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

default_run_options[:pty] = true
# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
ssh_options[:paranoid] = false
set :use_sudo,false
task :stamp, :hosts => "10.3.3.69" do
  #puts " ~/../"
  run "touch test.txt"
  run "git --version"
end

namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
      run "/cygdrive/d/apptool/restart-ex.bat"
   end


 end
task :update_pro,:roles=>:app do
  
  run "cp -f -r #{release_path}/app /cygdrive/d/www/#{application}/"
  run "cp -f -r #{release_path}/config /cygdrive/d/www/#{application}/"
  run "cp -f -r #{release_path}/db /cygdrive/d/www/#{application}/"
  run "cp -f -r #{release_path}/lib /cygdrive/d/www/#{application}/"
  run "cp -f -r #{release_path}/public /cygdrive/d/www/#{application}/"
  run "cp -f -r #{release_path}/script /cygdrive/d/www/#{application}/"
  run "cp -f -r #{release_path}/vendor /cygdrive/d/www/#{application}/"
  run "cp -f -r #{release_path}/app/views/layouts/application_deploy.rhtml /cygdrive/d/www/#{application}/app/views/layouts/application.rhtml"
end
#task :after_update_code, :roles => :app do
#  run "mkdir -p /cygdrive/e/rails_apps/#{application}/"
#  run "cp -f -r #{release_path}/app /cygdrive/e/rails_apps/#{application}/"
#  run "cp -f -r #{release_path}/config /cygdrive/e/rails_apps/#{application}/"
#  run "cp -f -r #{release_path}/db /cygdrive/e/rails_apps/#{application}/"
#  run "cp -f -r #{release_path}/lib /cygdrive/e/rails_apps/#{application}/"
#  run "cp -f -r #{release_path}/public /cygdrive/e/rails_apps/#{application}/"
#  run "cp -f -r #{release_path}/script /cygdrive/e/rails_apps/#{application}/"
#  run "cp -f -r #{release_path}/vendor /cygdrive/e/rails_apps/#{application}/"
#  
#
#end
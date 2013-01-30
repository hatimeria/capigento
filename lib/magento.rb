load Gem.find_files('capigento.rb').last.to_s

set :shared_children,     ["media", "var/session", "system"]

set :shared_files,        ["app/etc/local.xml"]

set :asset_children,      []

set :shared_var, false

namespace :deploy do
  desc "Symlink static directories and static files that need to remain between deployments."
  task :share_childs do
    if shared_children
      shared_children.each do |link|
        run "mkdir -p #{shared_path}/#{link}"
        run "if [ -d #{release_path}/#{link} ] ; then rm -rf #{release_path}/#{link}; fi"
        run "ln -nfs #{shared_path}/#{link} #{release_path}/#{link}"
      end
    end
    if shared_files
      shared_files.each do |link|
        link_dir = File.dirname("#{shared_path}/#{link}")
        run "mkdir -p #{link_dir}"
        run "touch #{shared_path}/#{link}"
        run "ln -nfs #{shared_path}/#{link} #{release_path}/#{link}"
      end
    end
    if shared_var
      run "mkdir -p #{shared_path}/var"
      run "if [ -d #{release_path}/var ] ; then rm -rf #{release_path}/var; fi"
      run "ln -nfs #{shared_path}/var #{release_path}/var"
    end
  end

  desc "Update latest release source path."
  task :finalize_update, :except => { :no_release => true } do
    run "chmod -R g+w #{release_path}" if fetch(:group_writable, true)

    if !shared_var
      run "if [ -d #{release_path}/var ] ; then rm -rf #{release_path}/var; fi"
      run "mkdir -p #{release_path}/var && chmod -R 0777 #{release_path}/var"
      run "if [ -d #{release_path}/var/cache ] ; then rm -rf #{release_path}/var/cache; fi"
      run "mkdir -p #{release_path}/var/cache && chmod -R 0777 #{release_path}/var/cache"
    end

    share_childs
  end
end


load Gem.find_files('capigento.rb').last.to_s

set :cache_path,          "var"

set :shared_children,     ["media", "downloader", "system"]

set :shared_files,        ["app/etc/local.xml", "index.php", ".htaccess"]

set :asset_children,      []

namespace :mage do
  desc "Removes all magento cache directories content"
  task :cc do
    clear_cache
    clear_media_cache
  end
  desc "Removes magento main cache directory content"
  task :clear_cache do
    run "if [ -d #{current_path}/var/cache ] ; then rm -rf #{current_path}/var/cache/*; fi"
  end
  desc "Removes magento assets cache directories content"
  task :clear_media_cache do
    run "if [ -d #{current_path}/media/css ] ; then rm -rf #{current_path}/media/css/*; fi"
    run "if [ -d #{current_path}/media/js ] ; then rm -rf #{current_path}/media/js/*; fi"
  end
end

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
  end

  desc "Update latest release source path."
  task :finalize_update, :except => { :no_release => true } do
    run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)
    run "if [ -d #{latest_release}/#{cache_path} ] ; then rm -rf #{latest_release}/#{cache_path}; fi"
    run "mkdir -p #{latest_release}/#{cache_path} && chmod -R 0777 #{latest_release}/#{cache_path}"

    share_childs
  end
end


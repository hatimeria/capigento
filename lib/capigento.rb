def prompt_with_default(var, default, &block)
  set(var) do
    Capistrano::CLI.ui.ask("#{var} [#{default}] : ", &block)
  end
  set var, default if eval("#{var.to_s}.empty?")
end

namespace :deploy do
  desc "Removed"
  task :start do ; end

  desc "Removed"
  task :restart do ; end

  desc "Removed"
  task :stop do ; end
  
  desc "Removed"
  task :cold do
    update
  end

  desc "Removed"
  task :testall do
  end

  desc "Removed"
  task :migrate do
  end
end

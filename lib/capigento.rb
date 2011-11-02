def prompt_with_default(var, default, &block)
  set(var) do
    Capistrano::CLI.ui.ask("#{var} [#{default}] : ", &block)
  end
  set var, default if eval("#{var.to_s}.empty?")
end

namespace :deploy do
  desc "Overwrite the start task because symfony doesn't need it."
  task :start do ; end

  desc "Overwrite the restart task because symfony doesn't need it."
  task :restart do ; end

  desc "Overwrite the stop task because symfony doesn't need it."
  task :stop do ; end
  
  desc "[Overload] We perform only update action"
  task :cold do
    update
  end

  desc "[Overload] Removed"
  task :testall do
  end

  desc "[Overload] Removed"
  task :migrate do
  end
end

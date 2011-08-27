require File.dirname(__FILE__) + '/../provizioning.rb'

policy :stack, :roles => :app do
  requires :build_essential
  requires :ruby, :ruby_gems
  requires :mysql
end

deployment do
  # mechanism for deployment
  delivery :capistrano do   
    begin
      recipes 'Capfile'
      recipes  "config/deploy/#{fetch(:stage, :development)}"
    rescue LoadError
      recipes 'deploy'
    end
  end

  # source based package installer defaults
  source do
    prefix   '/usr/local'
    archives '/usr/local/sources'
    builds   '/usr/local/build'
  end
end

# Depend on a specific version of sprinkle 
begin
  gem 'sprinkle', ">= 0.2.3"
rescue Gem::LoadError
  puts "sprinkle 0.2.3 required.\n Run: `sudo gem install sprinkle`"
  exit
end

# Capistrano integration

* Add require directives

require 'rubygems'
require 'sprinkle_packages/capistrano'


* Create deployment script
rails-app/config/deploy/development.rb # multistage setup
rails-app/config/deploy.rb # default setup

Here you can use sprinkle.run command

** load_packages from this gem
** setup sprinkle new packages => package(:mysql) {}
** policy setup
** deployment setup
** add more sprinkle stuff

* Run capistrano
 bundle exec cap development myserver :build
 bundle exec cap production myserver :build


## Setup example
Capistrano integration multistages
rails-app/config/deploy/development.rb

namespace :myserver do

  task :build do

    sprinkle.run(:testing => true) do
      load_packages # :only => [:mysql] or :except => [:mysql]  default all

      policy :test-stack, :roles => :app do
        requires :mysql
        requires :deploy_user
        requires :nginx
        requires :build_essential
      end

      deployment do
        delivery :capistrano do
          recipes 'Capfile'
          recipes 'config/deploy/development.rb'
        end
        source do
          prefix '/usr/local'
          archives '/usr/local/sources'
          builds '/usr/local/build'
        end
      end

    end
  end
end

In the Sprinkle package configuration you can use capistrano variables
puts Package.fetch :rails_env => development

package :mysql, :provides # => :database do
description 'MySQL Database'
apt %w( mysql-server mysql-client libmysqlclient15-dev )
end

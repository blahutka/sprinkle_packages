# Capistrano integration
-
#### 1. Add require directives to Capfile
```require 'rubygems'```

```require 'sprinkle_packages/capistrano'```
 

#### 2. Create deployment script

Mulsti stage setup
```config/deploy/development.rb``` and ```config/deploy/development.rb```

or default setup
``` config/deploy.rb```

In these files you can use sprinkle.run command to:

+ load_packages from this gem
+ setup sprinkle new packages => package(:mysql) {}
+ policy sprinkle setup
+ deployment sprinkle setup
+ add more sprinkle stuff

#### 3. Run capistrano (multistage example)
 In your rails project
 
```bundle exec cap development myserver:build```
or
```bundle exec cap production myserver:build```


## Setup example
Capistrano task 
```rails-app/config/deploy/development.rb```


```
namespace :myserver do

  task :build do

    sprinkle.run(:testing => true) do
      load_packages  #:only => [:mysql] or :except => [:mysql] or it load all packages

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
```

```bundle exec cap myserver:build```


# Variables
In the Sprinkle package configuration you can use capistrano variables
```puts Package.fetch(:rails_env)      # => development```

```
package :mysql, :provides => :database do
description 'MySQL Database'
  puts Package.fetch :rails_env
  apt %w( mysql-server mysql-client libmysqlclient15-dev )
end
```

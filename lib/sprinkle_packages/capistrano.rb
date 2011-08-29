Capistrano::Configuration.instance(:must_exist).load do

  # Deployment blocks specify deployment specific information about a
  # sprinkle script. An example in Capistrano task:
  #
  # namespace :myserver do

  #  task :build do

  #    sprinkle.run(:testing => true) do
  #      load_packages    # :only => [:mysql] or :except => [:mysql]  default all
  #
  #      policy :test-stack, :roles => :app do
  #        requires :mysql
  #        requires :deploy_user
  #        requires :nginx
  #        requires :build_essential
  #      end
  #
  #      deployment do
  #        delivery :capistrano do
  #          recipes 'Capfile'
  #          recipes 'config/deploy/development.rb'
  #        end
  #        source do
  #          prefix '/usr/local'
  #          archives '/usr/local/sources'
  #          builds '/usr/local/build'
  #        end
  #      end
  #
  #    end
  #  end
  # end
  #
  # In the Sprinkle package configuration you can use capistrano variables
  # puts Package.fetch :rails_env   # => development
  #
  # package :mysql, :provides => :database do
  # description 'MySQL Database'
  #  apt %w( mysql-server mysql-client libmysqlclient15-dev )
  # end



  namespace :sprinkle do

    module Package
      @@capistrano = {}

      def self.set_variables=(set)
        @@capistrano = set
      end

      def self.fetch(name)
        @@capistrano[name]
      end
    end

    def run(options={}, capistrano = self.variables, &block)
      require 'sprinkle_packages'
      params = {:verbose => true, :testing => true, :cloud => true}.merge!(options)
      Package.set_variables = capistrano
      Sprinkle::OPTIONS.merge!(options)
      spr = Sprinkle::Script.new

      def spr.load_packages(options={})
        select_type = if options.include?(:only) then
                        :only
                      elsif options.include?(:except) then
                        :except
                      else
                        :all
                      end
        Dir[File.dirname(__FILE__) + "/packages/**/*.rb"].each do |path|

          file_sym = path.split('/').last.sub('.rb', '').to_sym
          case select_type
            when :only
              require path if options[:only].include?(file_sym)
            when :except
              require path unless options[:except].include?(file_sym)
            when :all
              require path
            else
              raise 'Nothing to load'
          end

        end
      end

      spr.instance_eval(&block) if block_given?
      spr.sprinkle
    end
  end


end

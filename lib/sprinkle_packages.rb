require "sprinkle_packages/version"
require "sprinkle"

module SprinklePackages
  require 'sprinkle_packages/provizioning'
  #class Runner
  #  attr_accessor :policies, :setup
  #
  #  def initialize(&block)
  #
  #    ActiveSupport::BufferedLogger.silencer = true
  #    Sprinkle::OPTIONS[:verbose] = true
  #    Sprinkle::OPTIONS[:testing] = true
  #
  #    self.setup = Sprinkle::Script.new
  #
  #    @policies = []
  #
  #    instance_eval &block if block_given?
  #  end
  #
  #  def self.run(&block)
  #    new(&block)
  #  end
  #
  #  def policies(*params)
  #    @policies += params unless params.empty?
  #    @policies
  #  end
  #
  #  alias_method :policy, :policies
  #
  #  def policy_file_path(name)
  #    File.expand_path(File.join(File.dirname(__FILE__), 'sprinkle_packages/policies/', name.to_s + '.rb'))
  #  end
  #
  #  def policies_exists?
  #    self.policies.each do |s|
  #      path = self.policy_file_path(s)
  #      unless File.exists?(path)
  #        puts "!! Policy file not found: "+path
  #        return false
  #      end
  #    end
  #    true
  #  end
  #
  #  def build_script
  #
  #    return false unless policies_exists?
  #
  #    self.policies.each do |name|
  #      file = policy_file_path(name)
  #      script = File.read(file)
  #      self.setup.instance_eval(script, file)
  #    end
  #
  #    self.setup.deployment do
  #      delivery :capistrano do
  #        set :user, :vagrant
  #        role :app, 'dumsnadno-dev'
  #      end
  #    end
  #    self.setup
  #  end
  #
  #  def run
  #    policies = self.build_script
  #    policies.sprinkle if policies
  #  end
  #
  #end
end

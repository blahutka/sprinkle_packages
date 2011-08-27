require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SprinklePackages do

  describe '#policies' do
    before :each do
       #Sprinkle::Policy::POLICIES = []
      @sprinkle = SprinklePackages::Runner.new

    end

    it 'should have 0 policies' do
      @sprinkle.policies.should have(0).policies
    end

    it 'should have 2 policies' do
      @sprinkle.policies :name, :test
      @sprinkle.policies :more
      @sprinkle.policies.should have(3).policies
    end

    it 'it should return self' do
      @sprinkle.should be_instance_of(SprinklePackages::Runner)
    end

    it 'should have 2 polici packages' do
      @sprinkle.policies 'install-rails', :my
      @sprinkle.policies.should include('install-rails', :my)
    end

    it 'should have files path to policies file' do
      @sprinkle.policies 'install-rails'
      @sprinkle.policies_exists?.should be_true
    end

    it 'should not have path to policies file' do
      @sprinkle.policies :test_name
      @sprinkle.policies_exists?.should be_false
    end

    it 'should have alias method policy' do
      @sprinkle.policy :test_me
      @sprinkle.policies.should have(1).policies
    end

    it 'should be instance Sprinkle::Script' do
      @sprinkle.policy 'install-rails', 'install'
      @sprinkle.build_script.should be_instance_of(Sprinkle::Script)
    end

    it 'should clear policies' do
      #@sprinkle = SprinklePackages::Runner.new
      @sprinkle.policies 'install-rails'
      @sprinkle.policies.should have(1).items
           
    end

    it 'should clear script' do
      @sprinkle.policies.should have(0).items
      #@sprinkle.policies :testme
      #@sprinkle.policies.should have(2).items
      @sprinkle.run.should == ''
    end

    it 'should run sprinkle with output', :exclude => true do
      @sprinkle.policies = []
      @sprinkle.policy 'install-rails'
      @sprinkle.run.should have(1).item

    end


    it 'should contain', :exclude => true do
      pending
      require "sprinkle"
      Sprinkle::OPTIONS[:cloud]
      Sprinkle::OPTIONS[:verbose] = true
      Sprinkle::OPTIONS[:testing] = true
      spr = Sprinkle::Script.new
      spr.package :mysql do
        apt 'vim'
        verify { has_executable 'vim' }
      end

      spr.policy :stack, :roles => :app do
        requires :mysql
      end

      spr.deployment do
        delivery :capistrano do
          set :user, :vagrant
          role :app, 'dumsnadno-dev'
        end
      end
      spr.sprinkle.should have(1).items
    end


  end


end

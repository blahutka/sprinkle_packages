require "sprinkle_packages/version"
require "sprinkle"

module SprinklePackages
  class Import
    def initialize
      require 'sprinkle_packages/provizioning'
    end
  end
  
end

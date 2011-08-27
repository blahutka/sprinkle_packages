$TESTING=true


$:.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "sprinkle_packages"

RSpec.configure do |c|
  c.filter_run_excluding :exclude => true
end




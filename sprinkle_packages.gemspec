# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sprinkle_packages/version"

Gem::Specification.new do |s|
  s.name        = "sprinkle_packages"
  s.version     = SprinklePackages::VERSION
  s.authors     = ["blahutka"]
  s.email       = ["blahutka@centrum.cz"]
  s.homepage    = ""
  s.summary     = %q{Deployment packages for sprinkle gem}
  s.description = %q{Packages for automated installation of linux servers}

  s.rubyforge_project = "sprinkle_packages"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  %w(rspec guard rb-inotify libnotify guard-rspec).each do |lib|
    s.add_development_dependency lib
  end
  s.add_runtime_dependency "sprinkle", '>= 0.3.5'
  s.add_runtime_dependency 'i18n'
end

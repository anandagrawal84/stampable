# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "stampable/version"
require "stampable/base"

Gem::Specification.new do |s|
  s.name        = "stampable"
  s.version     = Stampable::VERSION
  s.authors     = ["Anand Agrawal"]
  s.email       = ["anand.agrawal84@gmail.com", "rajashreermalvade@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Stamp any ActiveRecord model with last created/updated by}
  s.description = %q{Stamp any ActiveRecord model with last created/updated by}

  s.rubyforge_project = "stampable"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end

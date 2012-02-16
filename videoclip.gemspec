# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name    = "videoclip"
  gem.version = "1.0.0"

  gem.authors     = ["Steve Richert"]
  gem.email       = ["steve.richert@gmail.com"]
  gem.description = "Save videos from popular sites alongside your ActiveRecord models"
  gem.summary     = "Save videos from popular sites alongside your ActiveRecord models"
  gem.homepage    = "https://github.com/laserlemon/videoclip"

  gem.add_dependency "activerecord", "~> 3.0"

  gem.add_development_dependency "rake",    "~> 0.9"
  gem.add_development_dependency "rspec",   "~> 2.8"
  gem.add_development_dependency "sqlite3", "~> 1.3"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- spec/*`.split("\n")
  gem.require_paths = ["lib"]
end

# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{videoclip}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Steve Richert"]
  s.date = %q{2009-05-28}
  s.description = %q{Save videos from popular sites alongside your ActiveRecord models}
  s.email = %q{steve@laserlemon.com}
  s.extra_rdoc_files = ["lib/videoclip/video.rb", "lib/videoclip/videos/youtube.rb", "lib/videoclip.rb", "README.rdoc", "tasks/videoclip_tasks.rake"]
  s.files = ["init.rb", "lib/videoclip/video.rb", "lib/videoclip/videos/youtube.rb", "lib/videoclip.rb", "Manifest", "MIT-LICENSE", "Rakefile", "README.rdoc", "tasks/videoclip_tasks.rake", "test/test_helper.rb", "test/videoclip_test.rb", "VERSION.yml", "videoclip.gemspec"]
  s.homepage = %q{http://github.com/laserlemon/videoclip}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Videoclip", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{videoclip}
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Save videos from popular sites alongside your ActiveRecord models}
  s.test_files = ["test/test_helper.rb", "test/videoclip_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

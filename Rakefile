require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('videoclip', '0.2.0') do |g|
  g.description = %(Save videos from popular sites alongside your ActiveRecord models)
  g.url = 'http://github.com/laserlemon/videoclip'
  g.author = 'Steve Richert'
  g.email = 'steve@laserlemon.com'
  g.ignore_pattern = %w(tmp/* script/*)
  g.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each{|t| load t }

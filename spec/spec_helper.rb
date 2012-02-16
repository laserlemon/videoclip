require "active_record"
require "videoclip"

Dir[File.expand_path("../support/**/*.rb", __FILE__)].each{|f| require f }

RSpec.configure do |config|
  config.before do
    Videoclip::Video.implementations.clear
  end
end

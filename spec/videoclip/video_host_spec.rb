require 'spec_helper'

describe 'Video::Host' do
  it 'should provide a url method which takes a video key' do
    # Video::Host::Vimeo.new.url('9679622').should eq("http://vimeo.com/9679622")
  end

  it 'should have a name attribute' do
    # Video::Host::YouTube.new.name.should eq("YouTube")
  end

  it 'should have a domain attribute' do
    # Video::Host::YouTube.new.domain.should eq("www.youtube.com")
  end

  it 'should implement to_s' do
    # Video::Host::Vimeo.new.to_s.should eq("Vimeo")
  end

  it 'should implement inspect' do
    # Video::Host::YouTube.new.inspect.should eq(%(#<Video::Host::YouTube name: "YouTube", domain: "www.youtube.com", url: "http://www.youtube.com/watch?v=:video_key">))
  end
end

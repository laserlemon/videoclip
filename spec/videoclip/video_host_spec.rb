require 'spec_helper'

describe 'Video::Host' do
  describe ".url" do
    it 'should be the base URL' do
      # Video::Host::Vimeo.url.should eq("http://vimeo.com/")
    end
  end

  describe ".url_for" do
    it 'should accept a video id and return the canonical URL to that video' do
      # Video::Host::Vimeo.url_for('9679622').should eq("http://vimeo.com/9679622")
    end
  end

  describe ".name" do
    it 'should return the human name of the host' do
      # Video::Host::YouTube.name.should eq("YouTube")
    end

    it 'should be aliased as .to_s' do
      # Video::Host::YouTube.to_s.should eq("YouTube")
    end
  end

  describe ".domain" do
    it 'should return the domain name of the host' do
      # Video::Host::YouTube.domain.should eq("www.youtube.com")
    end
  end

  describe ".inspect" do
    it 'should return a "pretty" inspection' do
      # Video::Host::YouTube.inspect.should eq(%(#<Video::Host::YouTube name: "YouTube", domain: "www.youtube.com", url_format: "http://www.youtube.com/watch?v=:id">))
    end
  end
end

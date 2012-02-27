require "spec_helper"

describe Videoclip::Video do
  context ".implementations" do
    it "keeps track of its inherited video classes" do
      Videoclip::Video.implementations.should == []
      class CustomVideo < Videoclip::Video; end
      Videoclip::Video.implementations.should == [CustomVideo]
    end

    it "puts the most recently inherited video class first" do
      Videoclip::Video.implementations.should == []
      class GoodVideo   < Videoclip::Video; end
      class BetterVideo < Videoclip::Video; end
      Videoclip::Video.implementations.should == [BetterVideo, GoodVideo]
    end
  end

  context ".parse" do
    it "parses HTTP URLs" do
      url = "http://www.youtube.com/watch?v=qybUFnY7Y8w"
      uri = Videoclip::Video.parse(url)
      uri.should be_a(URI::HTTP)
      uri.to_s.should == url
    end

    it "parses HTTPS URLs" do
      url = "https://www.youtube.com/watch?v=qybUFnY7Y8w"
      uri = Videoclip::Video.parse(url)
      uri.should be_a(URI::HTTPS)
      uri.to_s.should == url
    end

    it "normalizes valid URLs" do
      uri = Videoclip::Video.parse("HTTP://WWW.YOUTUBE.COM/watch?v=qybUFnY7Y8w")
      uri.to_s.should == "http://www.youtube.com/watch?v=qybUFnY7Y8w"
    end

    it "bombs on invalid URLs" do
      url = "youtube.com/watch?v=qybUFnY7Y8w"
      expect{ Videoclip::Video.parse(url) }.to raise_error(Videoclip::InvalidUrl)
    end
  end

  context ".match" do
    def match
      url = "http://www.youtube.com/watch?v=qybUFnY7Y8w"
      uri = Videoclip::Video.parse(url)
      Videoclip::Video.match(uri)
    end

    it "calls .matches? on implementations" do
      camera_1, camera_2 = mock, mock
      Videoclip::Video.implementations.replace([camera_1, camera_2])
      camera_1.should_receive(:matches?).once
      camera_2.should_receive(:matches?).once
      match rescue nil
    end

    it "returns the first implementation that matches" do
      camera_1, camera_2 = mock(:matches? => true), mock(:matches? => false)
      Videoclip::Video.implementations.replace([camera_1, camera_2])
      match.should == camera_1

      camera_1, camera_2 = mock(:matches? => false), mock(:matches? => true)
      Videoclip::Video.implementations.replace([camera_1, camera_2])
      match.should == camera_2

      camera_1, camera_2 = mock(:matches? => true), mock(:matches? => true)
      Videoclip::Video.implementations.replace([camera_1, camera_2])
      match.should == camera_1
    end

    it "bombs if no implementations match" do
      camera_1, camera_2 = mock(:matches? => false), mock(:matches? => false)
      Videoclip::Video.implementations.replace([camera_1, camera_2])
      expect{ match }.to raise_error(Videoclip::UnrecognizedUrl)
    end
  end

  context "[other]" do
    it 'should have a class-level match? method' do
      # Video.should respond_to(:match?)
      # Video.match?("http://vimeo.com/9679622").should be_false
      # Video::Vimeo.should respond_to(:match?)
      # Video::Vimeo.match?("http://vimeo.com/9679622").should be_true
    end

    it 'should have a host attribute which is a kind of Video::Host' do
      # host = Video.new("http://vimeo.com/9679622").host
      # host.should be_kind_of(Video::Host)
      # host.should be_an_instance_of(Video::Host::Vimeo)
    end

    it 'should have a key attribute' do
      # Video.new("http://vimeo.com/9679622").key.should eq('9679622')
    end

    it 'should have a url attribute' do
      # Video.new("http://www.youtube.com/watch?v=pv5zWaTEVkI&feature=related").url.should eq('http://www.youtube.com/watch?v=pv5zWaTEVkI')
    end

    it 'should provide a way to embed the video' do
      # Video.new("foobar").should respond_to(:embed)
      # Video.new("foobar").embed.should be_nil
      # Video::Vimeo.new("http://vimeo.com/9679622").should respond_to(:embed)
      # Video.new("http://vimeo.com/9679622").embed.should eq(load_html_for_example(:vimeo_embed))
    end

    it 'should implement to_s' do
      # Video.new("http://vimeo.com/9679622").to_s.should eq('http://vimeo.com/9679622')
    end

    it 'should implement inspect' do
      # Video.new("http://vimeo.com/9679622").inspect.should eq(%(#<Video::Vimeo host: #{Video::Host::Vimeo.new.inspect}, key: "9679622", url: "http://vimeo.com/9679622", embed: #{(load_html_for_example(:vimeo_embed)[0..80] + '...').inspect}>))
    end
  end
end

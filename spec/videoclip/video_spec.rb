require "spec_helper"

describe Videoclip::Video do
  context ".implementations" do
    it "keeps track of its inherited video classes" do
      Videoclip::Video.implementations.should == []
      class CustomVideo < Videoclip::Video; end
      Videoclip::Video.implementations.should == [CustomVideo]
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
end

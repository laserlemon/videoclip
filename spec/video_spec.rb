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
  end
end

require "spec_helper"

describe Videoclip::Video do
  it "keeps track of its inherited video classes" do
    Videoclip::Video.implementations.should == []
    class CustomVideo < Videoclip::Video; end
    Videoclip::Video.implementations.should == [CustomVideo]
  end
end

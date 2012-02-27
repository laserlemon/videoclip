require "spec_helper"

describe "Videoclip::Video implementation" do
  describe :host do
    it 'should return a Videoclip::Video::Host instance' do
      # host = Video.new("http://vimeo.com/9679622").host
      # host.should be_kind_of(Video::Host)
      # host.should be_an_instance_of(Video::Host::Vimeo)
    end
  end

  describe :id do
    it 'should be the video’s unique identifier' do
      # Video.new("http://vimeo.com/9679622").id.should eq('9679622')
    end
  end

  describe :url do
    it 'should be the base URL for the video' do
      # Video.new("http://www.youtube.com/watch?v=pv5zWaTEVkI&feature=related").url.should eq('http://www.youtube.com/watch?v=pv5zWaTEVkI')
    end
  end

  describe :embed do
    it 'should return embeddable code to display the video' do
      # Video.new("foobar").should respond_to(:embed)
      # Video.new("foobar").embed.should be_nil
      # Video::Vimeo.new("http://vimeo.com/9679622").should respond_to(:embed)
      # Video.new("http://vimeo.com/9679622").embed.should eq(load_html_for_example(:vimeo_embed))
    end
  end

  describe :to_s do
    it 'should basically return the URL' do
      # Video.new("http://vimeo.com/9679622").to_s.should eq('http://vimeo.com/9679622')
    end
  end

  describe :inspect do
    it 'should give some "pretty" output about this video object' do
      # Video.new("http://vimeo.com/9679622").inspect.should eq(%(#<Video::Vimeo host: #{Video::Host::Vimeo.new.inspect}, key: "9679622", url: "http://vimeo.com/9679622", embed: #{(load_html_for_example(:vimeo_embed)[0..80] + '...').inspect}>))
    end
  end
end

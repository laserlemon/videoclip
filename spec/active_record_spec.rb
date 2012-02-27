require 'spec_helper'

describe 'hooking into ActiveRecord' do
  it 'should only need one column to store its data' do
    User.columns_hash.keys.should eq(["id", "name", "video", "intro", "bio", "created_at", "updated_at"])
  end

  it 'should only need to store the canonical URL' do
    class VimeoVideo < Videoclip::Video
      def self.matches?(*); true end
      def load(uri) @id, @url = uri.to_s.reverse.split('/', 2).map(&:reverse); self end
    end
    User.has_video :video
    obj = User.create(:video => "http://vimeo.com/24933302")
    obj.read_attribute(:video).should eq("http://vimeo.com 24933302")
  end

  it 'should provide an option to specify what the actual column is named' do
    # Model.columns_hash.keys.should eq(["id", "video_url"])
    # Model.has_attached_video :video, :from => :video_url
    # obj = Model.create(:video => "http://www.youtube.com/watch?v=pv5zWaTEVkI&feature=related")
    # obj.video.should be_an_instance_of(Videoclip::Video)
    # obj.video.host.should eq('YouTube')
    # obj.video.id.should eq('pv5zWaTEVkI')
  end

  it 'should have a user-defined name for the video attribute' do
    # Model.columns_hash.keys.should eq(["id", "something_else"])
    # Model.has_attached_video :awesomeness, :from => :something_else
    # obj = Model.create(:awesomeness => "http://vimeo.com/9679622")
    # obj.awesomeness.should be_an_instance_of(Videoclip::Video)
    # obj.awesomeness.host.should eq('Vimeo')
    # obj.awesomeness.id.should eq('9679622')
  end
end

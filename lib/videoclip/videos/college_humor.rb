module LaserLemon
  module Videoclip
    class Video::CollegeHumor < Video
      def self.match?(uri)
        (uri.host =~ /^(?:www\.)?collegehumor\.com$/i) && (uri.path =~ /^\/video:\d+/)
      end

      def assign(uri)
        @key = uri.path.match(/^\/video:(\d+)/)[1]
        @url = "http://www.collegehumor.com/video:#{@key}"
      end

      def embed(style = nil)
        %(<object type="application/x-shockwave-flash" data="http://www.collegehumor.com/moogaloop/moogaloop.swf?clip_id=#{@key}&fullscreen=1" width="#{width(style)}" height="#{height(style)}" ><param name="allowfullscreen" value="true"/><param name="wmode" value="transparent"/><param name="allowScriptAccess" value="always"/><param name="movie" quality="best" value="http://www.collegehumor.com/moogaloop/moogaloop.swf?clip_id=#{@key}&fullscreen=1"/><embed src="http://www.collegehumor.com/moogaloop/moogaloop.swf?clip_id=#{@key}&fullscreen=1" type="application/x-shockwave-flash" wmode="transparent"  width="#{width(style)}" height="#{height(style)}" allowScriptAccess="always"></embed></object>)
      end
    end
  end
end

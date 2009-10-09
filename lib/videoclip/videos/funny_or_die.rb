module LaserLemon
  module Videoclip
    class Video::FunnyOrDie < Video
      def self.match?(uri)
        (uri.host =~ /^(?:www\.)?funnyordie\.com$/i) && (uri.path =~ /^\/videos\/[0-9a-f]{10}\//)
      end

      def assign(uri)
        @key = uri.path.match(/^\/videos\/([0-9a-f]{10})\//)[1]
        @url = "http://www.funnyordie.com/videos/#{@key}"
      end

      def embed(style = nil)
        %(<object width="#{width(style)}" height="#{height(style)}" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" id="ordie_player_#{@key}"><param name="movie" value="http://player.ordienetworks.com/flash/fodplayer.swf" /><param name="flashvars" value="key=#{@key}" /><param name="allowfullscreen" value="true" /><param name="allowscriptaccess" value="always"></param><embed width="#{width(style)}" height="#{height(style)}" flashvars="key=#{@key}" allowfullscreen="true" allowscriptaccess="always" quality="high" src="http://player.ordienetworks.com/flash/fodplayer.swf" name="ordie_player_#{@key}" type="application/x-shockwave-flash"></embed></object>)
      end

      protected
        def chrome_height
          40
        end
    end
  end
end

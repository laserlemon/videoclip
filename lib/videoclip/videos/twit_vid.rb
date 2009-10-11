module LaserLemon
  module Videoclip
    class Video::TwitVid < Video
      def self.match?(uri)
        (uri.host =~ /^(?:www\.)?twitvid\.com$/i) && (uri.path =~ /^\/[0-9A-F]{5,}/)
      end

      def assign(uri)
        @key = uri.path.match(/^\/([0-9A-F]{5,})/)[1]
        @url = "http://www.twitvid.com/#{@key}"
      end

      def embed(style = nil)
        %(<object width="#{width(style)}" height="#{height(style)}"><param name="movie" value="http://www.twitvid.com/player/#{@key}"></param><param name="allowFullScreen" value="true"></param><embed type="application/x-shockwave-flash" src="http://www.twitvid.com/player/#{@key}" quality="high" allowscriptaccess="always" allowNetworking="all" allowfullscreen="true" wmode="transparent" height="#{height(style)}" width="#{width(style)}"></object>)
      end
    end
  end
end

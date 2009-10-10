module LaserLemon
  module Videoclip
    class Video::DailyMotion < Video
      def self.match?(uri)
        (uri.host =~ /^(?:www\.)?dailymotion\.com$/i) && (uri.path =~ /\/video\/[^_]+_/)
      end

      def assign(uri)
        @key = uri.path.match(/\/video\/([^_]+)_/)[1]
        @url = "http://www.dailymotion.com/video/#{@key}"
      end

      def embed(style = nil)
        %(<object width="#{width(style)}" height="#{height(style)}"><param name="movie" value="http://www.dailymotion.com/swf/#{@key}" /><param name="allowFullScreen" value="true" /><param name="allowScriptAccess" value="always" /><embed src="http://www.dailymotion.com/swf/#{@key}" type="application/x-shockwave-flash" width="#{width(style)}" height="#{height(style)}" allowFullScreen="true" allowScriptAccess="always"></embed></object>)
      end

      protected
        def chrome_height
          20
        end
    end
  end
end

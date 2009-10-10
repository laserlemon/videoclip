module LaserLemon
  module Videoclip
    class Video::Metacafe < Video
      def self.match?(uri)
        (uri.host =~ /^(?:www\.)?metacafe\.com$/i) && (uri.path =~ /^\/watch\/\d+\//)
      end

      def assign(uri)
        @key = uri.path.match(/^\/watch\/(\d+)\//)[1]
        @url = "http://www.metacafe.com/videos/#{@key}"
      end

      def embed(style = nil)
        %(<embed src="http://www.metacafe.com/fplayer/#{@key}/video.swf" width="#{width(style)}" height="#{height(style)}" wmode="transparent" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" allowFullScreen="true" allowScriptAccess="always" name="Metacafe_#{@key}"></embed>)
      end

      protected
        def chrome_height
          32
        end
    end
  end
end

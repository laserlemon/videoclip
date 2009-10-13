module LaserLemon
  module Videoclip
    class Video::Yahoo < Video
      def self.match?(uri)
        (uri.host =~ /^video\.yahoo\.com$/i) && (uri.path =~ /^\/watch\/\d+\/\d+/)
      end

      def assign(uri)
        @key = uri.path.match(/^\/watch\/(\d+\/\d+)/)[1]
        @url = "http://video.yahoo.com/videos/#{@key}"
      end

      def embed(style = nil)
        %(<object width="#{width(style)}" height="#{height(style)}"><param name="movie" value="http://d.yimg.com/static.video.yahoo.com/yep/YV_YEP.swf?ver=2.2.46" /><param name="allowFullScreen" value="true" /><param name="AllowScriptAccess" VALUE="always" /><param name="bgcolor" value="#000000" /><param name="flashVars" value="id=#{ids.last}&vid=#{ids.first}&lang=en-us&intl=us&thumbUrl=http%3A//l.yimg.com/a/p/i/bcst/videosearch/3013/91396661.jpeg&embed=1" /><embed src="http://d.yimg.com/static.video.yahoo.com/yep/YV_YEP.swf?ver=2.2.46" type="application/x-shockwave-flash" width="#{width(style)}" height="#{height(style)}" allowFullScreen="true" AllowScriptAccess="always" bgcolor="#000000" flashVars="id=#{ids.last}&vid=#{ids.first}&lang=en-us&intl=us&thumbUrl=http%3A//l.yimg.com/a/p/i/bcst/videosearch/3013/91396661.jpeg&embed=1"></embed></object>)
      end

      protected
        def chrome_height
          34
        end

        def ids
          @key.split('/')
        end
    end
  end
end

module LaserLemon
  module Videoclip
    class Video::Spike < Video
      def self.match?(uri)
        (uri.host =~ /^(?:www\.)?spike\.com$/i) && (uri.path =~ /^\/video\/[^\/]+\/\d+/)
      end

      def assign(uri)
        @key = uri.path.match(/^\/video\/[^\/]+\/(\d+)/)[1]
        @url = "http://www.spike.com/video/x/#{@key}"
      end

      def embed(style = nil)
        %(<embed width="#{width(style)}" height="#{height(style)}" src="http://www.spike.com/efp" quality="high" bgcolor="000000" name="efp" align="middle" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" flashvars="flvbaseclip=#{@key}" allowfullscreen="true"></embed>)
      end

      protected
        def chrome_height
          30
        end
    end
  end
end

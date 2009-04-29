module LaserLemon
  module Videoclip
    class Video::Youtube < Video
      def self.match?(uri)
        (uri.host =~ /^(?:www\.)?youtube\.com$/i) && (uri.path == '/watch') && !CGI.parse(uri.query)['v'].blank?
      end
      
      def assign(uri)
        @key = CGI.parse(uri.query)['v'].first
        @url = "http://www.youtube.com/watch?v=#{@key}"
      end
      
      def embed(style = nil)
        %(<object width="#{width(style)}" height="#{height(style)}"><param name="movie" value="http://www.youtube.com/v/#{key}&hl=en&fs=1"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube.com/v/#{key}&hl=en&fs=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="#{width(style)}" height="#{height(style)}"></embed></object>)
      end
      
      protected
      
      def chrome_height
        25
      end
    end
  end
end

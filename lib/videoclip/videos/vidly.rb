module LaserLemon
  module Videoclip
    class Video::Vidly < Video
      def self.match?(uri)
        (uri.host =~ /^(?:www\.)?vidly\.com$/i) && (uri.path =~ /^\/[a-z]{4,}/i)
      end

      def assign(uri)
        @key = uri.path.match(/^\/([a-z]{4,})/i)[1]
        @url = "http://vidly.com/#{@key}"
      end

      def embed(style = nil)
        %(<object width="#{width(style)}" height="#{height(style)}"><param name="movie" value="http://vid.ly/embed/#{@key}"></param><param name="wmode" value="opaque"></param><param name="allowscriptaccess" value="always"></param><param name="allowfullscreen" value="yes"></param><embed src="http://vid.ly/embed/#{@key}" type="application/x-shockwave-flash" wmode="opaque" allowscriptaccess="always" allowfullscreen="yes" width="#{width(style)}" height="#{height(style)}"></embed></object>)
      end
    end
  end
end

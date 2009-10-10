module LaserLemon
  module Videoclip
    class Video::LiveLeak < Video
      def self.match?(uri)
        (uri.host =~ /^(?:www\.)?liveleak\.com$/i) && (uri.path == '/view') && !CGI.parse(uri.query)['i'].blank?
      end

      def assign(uri)
        @key = CGI.parse(uri.query)['i'].first
        @url = "http://www.liveleak.com/view?i=#{@key}"
      end

      def embed(style = nil)
        %(<object width="#{width(style)}" height="#{height(style)}"><param name="movie" value="http://www.liveleak.com/e/#{@key}"></param><param name="wmode" value="transparent"></param><embed src="http://www.liveleak.com/e/#{@key}" type="application/x-shockwave-flash" wmode="transparent" width="#{width(style)}" height="#{height(style)}"></embed></object>)
      end

      protected
        def chrome_height
          20
        end
    end
  end
end

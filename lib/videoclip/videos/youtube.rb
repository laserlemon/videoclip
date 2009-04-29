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
    end
  end
end

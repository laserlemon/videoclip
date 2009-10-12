module LaserLemon
  module Videoclip
    class Video::Vimeo < Video
      def self.match?(uri)
        (uri.host =~ /^(?:www\.)?vimeo\.com$/i) && (uri.path =~ /^\/\d+/)
      end

      def assign(uri)
        @key = uri.path.match(/^\/(\d+)/)[1]
        @url = "http://vimeo.com/#{@key}"
      end

      def embed(style = nil)
        %(<object width="#{width(style)}" height="#{height(style)}"><param name="allowfullscreen" value="true" /><param name="allowscriptaccess" value="always" /><param name="movie" value="http://vimeo.com/moogaloop.swf?clip_id=#{@key}&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1" /><embed src="http://vimeo.com/moogaloop.swf?clip_id=#{@key}&amp;server=vimeo.com&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1" type="application/x-shockwave-flash" allowfullscreen="true" allowscriptaccess="always" width="#{width(style)}" height="#{height(style)}"></embed></object>)
      end
    end
  end
end

class Blip < LaserLemon::Videoclip::Video
  def self.match?(uri)
    (uri.host =~ /^(?:www\.)?blip\.tv$/i) && (uri.path =~ /^\/file\/\d+$/)
  end
  
  def assign(uri)
    @url = "http://blip.tv#{uri.path}"
    response = Net::HTTP.get(URI.parse(@url + '?skin=api'))
    @key = parse_response(response, %w(response payload asset embed_lookup))
  end
  
  def embed(style = nil)
    %(<embed src="http://blip.tv/play/#{@key}" type="application/x-shockwave-flash" width="#{width(style)}" height="#{height(style)}" allowscriptaccess="always" allowfullscreen="true"></embed>)
  end
  
  protected
  
  def chrome_height
    30
  end
  
  def parse_response(response, path, default = nil)
    begin
      path.collect!(&:to_s)
      destination = path.pop
      path.inject(Hash.from_xml(response)){|h,p| h.fetch(p, {}) }.fetch(destination, default)
    rescue
      default
    end
  end
end

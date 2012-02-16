module Videoclip
  class Video
    def self.implementations
      @implementations ||= []
    end

    def self.inherited(klass)
      implementations << klass
    end

    def self.parse(url)
      uri = URI.parse(url)
      raise unless uri.is_a?(URI::HTTP)
      uri.normalize!
      uri
    rescue
      raise InvalidUrl
    end

    def self.match(uri)
      implementations.detect{|i| i.matches?(uri) } || raise
    rescue
      raise UnrecognizedUrl
    end

    def self.construct(value)
      url, id = value.split
      uri     = parse(url)
      klass   = match(uri)
      klass.new(url, id)
    end

    def self.convert(url)
      uri   = parse(url)
      klass = match(uri)
      klass.new.load(uri)
    end

    attr_reader :url, :id

    def initialize(url = nil, id = nil)
      @url, @id = uri, id
    end

    def destruct
      "#{url} #{id}"
    end
  end
end

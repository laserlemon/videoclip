module LaserLemon
  module Videoclip
    class Video
      cattr_reader :implementations
      @@implementations = []
      
      class << self
        def inherited(subclass)
          @@implementations << subclass
        end
        
        def match(uri, host = nil)
          begin
            klass = @@implementations.detect{|i| (i.host == host) || i.match?(uri) }
            raise if klass.nil?
          rescue
            raise UnrecognizedVideoHost
          else klass
          end
        end
        
        def parse_url(url)
          begin
            uri = URI.parse(url)
            raise unless uri.is_a?(URI::HTTP)
          rescue
            raise InvalidUrlFormat
          else uri
          end
        end
        
        def build(host, key, url)
          uri = parse_url(url)
          klass = match(uri, host)
          klass.new(key, url)
        end
        
        def assign(url)
          uri = parse_url(url)
          klass = match(uri)
          video = klass.new
          video.assign(uri)
          video
        end
        
        def host
          self.name.demodulize.underscore
        end
      end
      
      attr_reader :host, :key, :url
      
      def initialize(key = nil, url = nil)
        @host = self.class.host
        @key, @url = key, url
      end
    end
    
    class VideoclipError < StandardError
    end
    
    class InvalidUrlFormat < VideoclipError
    end
    
    class UnrecognizedVideoHost < VideoclipError
    end
  end
end

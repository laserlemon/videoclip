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
        
        def build(host, key, url, options = {})
          uri = parse_url(url)
          klass = match(uri, host)
          klass.new(key, url, options)
        end
        
        def assign(url, options = {})
          uri = parse_url(url)
          klass = match(uri)
          video = klass.new(nil, nil, options)
          video.assign(uri)
          video
        end
        
        def host
          self.name.demodulize.underscore
        end
      end
      
      attr_reader :host, :key, :url
      attr_accessor :options
      
      def initialize(key = nil, url = nil, options = {})
        @host = self.class.host
        @key, @url, @options = key, url, options
      end
      
      protected
      
      def width(style)
        s = get_style(style)
        w = s[:width] || (s[:height].to_f * aspect_ratio).floor
        w += chrome_width unless w.zero? || s[:include_chrome]
        w
      end
      
      def height(style)
        s = get_style(style)
        h = s[:height] || (s[:width].to_f / aspect_ratio).ceil
        h += chrome_height unless h.zero? || s[:include_chrome]
        h
      end
      
      def aspect_ratio
        16.0 / 9
      end
      
      def chrome_width
        0
      end
      
      def chrome_height
        0
      end
      
      private
      
      def get_style(style)
        case style
        when nil: get_style(default_style)
        when Hash: style
        when String: geometry_to_style(style)
        else get_style(styles.fetch(style, {}))
        end
      end
      
      def default_style
        style_name = case
        when @options.has_key?(:default_style): @options[:default_style]
        when styles.size == 1: styles.keys.first
        else :default
        end
        styles.fetch(style_name, {})
      end
      
      def styles
        @options.fetch(:styles, {})
      end
      
      def geometry_to_style(geometry)
        style = {}
        style[:include_chrome] = !geometry.dup.sub!(/!$/, '').nil?
        width, height = geometry.split('x')
        style.merge!(:width => width.to_i, :height => height.to_i)
        style.delete_if{|k,v| v == 0 }
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

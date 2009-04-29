require 'videoclip/video'
Dir.glob(Rails.root + '/lib/videoclip/*.rb').each{|v| require v }
Dir.glob(File.dirname(__FILE__) + '/videoclip/videos/*.rb').each{|v| require v }

module LaserLemon
  module Videoclip
    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods
      def has_video(name = :video, options = {})
        write_inheritable_hash(:videoclip_options, name.to_sym => options)
        composed_of name,
          :class_name => 'LaserLemon::Videoclip::Video',
          :mapping => %w(host key url).map{|x| %W(#{name}_#{x} #{x}) },
          :constructor => :build,
          :converter => :assign,
          :allow_nil => true
        
        define_method "#{name}?" do
          !! send(name)
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, LaserLemon::Videoclip)

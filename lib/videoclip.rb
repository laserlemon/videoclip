require 'videoclip/video'
Dir.glob(Rails.root + 'lib/videoclip/*.rb').each{|v| require v }
Dir.glob(File.dirname(__FILE__) + '/videoclip/videos/*.rb').each{|v| require v }

module LaserLemon
  module Videoclip
    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods
      def has_video(name = :video, options = {})
        class_inheritable_hash :videoclip_options
        self.videoclip_options = {name.to_sym => options}
        
        composed_of name,
          :class_name => 'LaserLemon::Videoclip::Video',
          :mapping => %w(host key url).map{|x| %W(#{name}_#{x} #{x}) },
          :constructor => Proc.new{|h,k,u| LaserLemon::Videoclip::Video.build(h, k, u, options) },
          :converter => Proc.new{|u| LaserLemon::Videoclip::Video.assign(u, options) },
          :allow_nil => true
        
        define_method "#{name}?" do
          !! send(name)
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, LaserLemon::Videoclip)

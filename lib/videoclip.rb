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
        class_inheritable_hash :videoclip_options
        self.videoclip_options = {name.to_sym => options}
        
        composed_of name,
          :class_name => 'LaserLemon::Videoclip::Video',
          :mapping => %w(host key url).map{|x| %W(#{name}_#{x} #{x}) },
          :constructor => :build,
          :converter => :assign,
          :allow_nil => true
        
        define_method "#{name}_with_options" do
          v = send("#{name}_without_options")
          v.options ||= self.class.videoclip_options[name.to_sym]
          v
        end
        
        alias_method_chain name, :options
        
        define_method "#{name}?" do
          !! send(name)
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, LaserLemon::Videoclip)

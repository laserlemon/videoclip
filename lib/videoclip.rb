require "uri"
require "videoclip/video"

module Videoclip
  def has_video(*names)
    names << :video if names.empty?

    names.each do |name|
      composed_of name,
        :class_name  => "Videoclip::Video",
        :mapping     => [name, :destruct],
        :allow_nil   => true,
        :constructor => :construct,
        :converter   => :convert
    end
  end
end

ActiveRecord::Base.extend Videoclip

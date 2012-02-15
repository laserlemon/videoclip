Videoclip
=========

Easily attach videos to your ActiveRecord models from all sorts of popular sites!

Videoclip was inspired by [Paperclip](https://github.com/thoughtbot/paperclip). It uses aggregation, just like Paperclip, to save the information necessary to link to or embed video from a number of sources.

In particular, Videoclip saves three values for each video:

* The host of the video ("youtube", "blip", etc.)
* A unique string key to identify the video
* A link back to the original source of the video

In addition, Videoclip can return the HTML needed to embed the video on your own site using the host and the key of the video. You can specify styles (much like you can using Paperclip) to define the size(s) at which you'd like to embed the video.

Example
-------

To use Videoclip in an ActiveRecord model, use the `has_video` method:

    class Product < ActiveRecord::Base
      has_video :video,
        styles: {large: "640x360", medium: "480x270", small: "320x240!"},
        default_style: :large
    end

In the example above, the first argument is the name of the video. You'll need to add three columns to your `products` table, each prefixed with the video name:

    class AddVideoToProducts < ActiveRecord::Migration
      def change
        add_column :products, :video_host, :string
        add_column :products, :video_key,  :string
        add_column :products, :video_url,  :string
      end
    end

Now attaching videos is a snap…

    >> p = Product.create(name: "Treadmill", video: "http://www.youtube.com/watch?v=pv5zWaTEVkI&feature=related")
    => #<Product name: "Treadmill", video_host: "youtube", video_key: "pv5zWaTEVkI", video_url: "http://www.youtube.com/watch?v=pv5zWaTEVkI">
    >> p.video.host
    => "youtube"
    >> p.video.key
    => "pv5zWaTEVkI"
    >> p.video.url
    => "http://www.youtube.com/watch?v=pv5zWaTEVkI"
    >> p.video.embed
    => "<object width=\"640\" height=\"385\"><param name=\"movie\" value=\"http://www.youtube.com/v/pv5zWaTEVkI&hl=en&fs=1\"></param><param name=\"allowFullScreen\" value=\"true\"></param><param name=\"allowscriptaccess\" value=\"always\"></param><embed src=\"http://www.youtube.com/v/pv5zWaTEVkI&hl=en&fs=1\" type=\"application/x-shockwave-flash\" allowscriptaccess=\"always\" allowfullscreen=\"true\" width=\"640\" height=\"385\"></embed></object>"
    >> p.update_attribute(:video, "http://blip.tv/file/62177")
    => "http://blip.tv/file/62177"
    >> p.video.host
    => "blip"
    >> p.video.key
    => "AYSAKwI"
    >> p.video.url
    => "http://blip.tv/file/62177"
    >> p.video.embed
    => "<embed src=\"http://blip.tv/play/AYSAKwI\" type=\"application/x-shockwave-flash\" width=\"640\" height=\"390\" allowscriptaccess=\"always\" allowfullscreen=\"true\"></embed>"
    >> p.video.embed(:small)
    => "<embed src=\"http://blip.tv/play/AYSAKwI\" type=\"application/x-shockwave-flash\"width=\"320\" height=\"240\" allowscriptaccess=\"always\" allowfullscreen=\"true\"></embed>"

There are a few things to note in the example above:

1. The input needed to create a video object is simply the URL of the video on its host site. This URL doesn't have to be perfectly formed. A canonical link will be stored.
2. The format of the embed string is unique to the video host and should closely resemble the embed string recommended by the host.
3. The actual dimensions used in the embed string may be larger than those specified in the model. This is due to additional controls (or "chrome") surrounding the played back video (note: this can be overridden, see below).

Styles
------

As seen in the above example, the `embed` method accepts a style argument to determine the output dimensions of the video. The style argument can be in one of three formats: a symbol, string or hash.

1. A symbol references a key in the `:style` hash of your `has_video` declaration
2. A string is used as a ImageMagick-ish representation of the geometry to use (see below)
3. A hash can be used to define the `:width` and `:height` of the embedded video as well as a boolean option, `:include_chrome` (see below)

The geometry string is a simpler form of an [ImageMagick geometry string](http://www.imagemagick.org/script/command-line-processing.php#geometry). For Videoclip, the geometry string follows a simple pattern:

    "#{width}x#{height}"

So the geometry `640x360` would output a video playback 640 pixels wide and 360 pixels tall. Note that embedded video from some hosts includes padding around the edges for controls called "chrome." For instance, Youtube adds 25 pixels of chrome to the bottom of each embedded video. For this reason, the default Videoclip behavior is to add the chrome dimensions to the video player dimensions. So a geometry of `640x360` would actually embed a Youtube player 640 pixels wide and 385 pixels tall. This keeps the viewable video size consistent.

However, if absolute dimensions are required, an exclamation point can be added to the end of a geometry to ensure that the chrome dimensions are included in the given dimensions, so that the embedded player will not exceed that size.

Additionally, either the width or the height values can be excluded. For the geometry `720x`, the viewable video will be 720 pixels wide and the height will be set according to that video host's default aspect ratio. The overriding default for all hosts is 16:9 so in this case, the height would be 405 pixels plus the height of the video host's chrome. Again, the chrome can be included in the dimensions by changing the geometry to `720x!`.

The width dimension can also be excluded. The geometry `x405` would yield the same results as `720x` for a 16:9 video host.

For a hash style declaration, the `:include_chrome` option is equivalent to appending an exclamation point to a geometry string.

As shown in the example, the `embed` method can also accept zero arguments, in which case the specified `:default_style` is used. If there is only a single style defined or if the default style is named `:default`, the `:default_style` option can be omitted.

Contributing
------------

Video sites are often changing the dimensions of their video players or the format of their URLs. Because of this, the `videoclip` video classes for these hosts will need to be updated as well. When an update is needed, please create a new [issue](https://github.com/laserlemon/videoclip/issues) or fork the repository yourself and fix away!

I'm always open to outside contribution and as long as your work is in line with the direction of the project, I'll more than likely include it, so feel free! Or if you're not comfortable hacking away at the code, please send me your feedback.

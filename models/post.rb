#encoding: utf-8
require_relative '../parser/og_parser'

class Post < Sequel::Model
  def app
    Naschwerk.new!
  end

  def after_save
    app.broadcast_telegram self.url, "#{User[self.user_id].name} postete im Naschwerk: #{self.title}"
  end

  def before_save

    end

    def load_image
      unless self.og_image.length == 0
        imagedata = open(self.og_image).read
        extname = app.get_extension(imagedata)
        local_filename = "image_#{self.id}.#{extname}"
        local_path = '../public/thumbnails/'
        self.localimage = local_filename
        app.resizeAndSaveImage imagedata, local_path, local_filename
      end
    end

    def gather_tags
      parser = OGParser.new
      parser.parse(self.url, 5)
      self.og_title = parser.get_title
      self.og_description = parser.get_description
      self.keywords = parser.get_keywords.to_json
      og_image_src = parser.get_image_uri
      if og_image_src.include? "http"
        self.og_image = parser.get_image_uri
      end
    end
end

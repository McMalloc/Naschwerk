require 'nokogiri'
require 'open-uri'
require 'openssl'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
class OGParser
  def parse (url, tries)
    begin
      puts url
      uri = URI.parse(url)
      tries = 3
      # if (url.include? "linkedin") || (url.include? "iterativintuitiv") || (url.include? "indiegogo") || (url.include? "deseat")
      #   return
      # end
      @doc = Nokogiri::HTML(open(uri))
    rescue #OpenURI::HTTPRedirect => redirect
      #uri = redirect.uri
      #retry if (tries -= 1) > 0
    end
  end

  def get_description
    if @doc.nil?
      return ''
    end
    (@doc.xpath '//*/meta[starts-with(@property, \'og:description\')]/@content').to_s
  end

  def get_title
    if @doc.nil?
      return ''
    end
    (@doc.xpath '//*/meta[starts-with(@property, \'og:title\')]/@content').to_s
  end

  def get_url
    if @doc.nil?
      return ''
    end
    (@doc.xpath '//*/meta[starts-with(@property, \'og:url\')]/@content').to_s
  end

  def get_image_uri
    if @doc.nil?
      return ''
    end
    src = (@doc.xpath '//*/link[starts-with(@rel, \'image_src\')]/@href').first.to_s
    if src.length == 0
      src = (@doc.xpath '//*/meta[starts-with(@property, \'og:image\')]/@content').first.to_s
    end
    src
  end

  def get_keywords
    if @doc.nil?
      return ''
    end
    (@doc.xpath '//*/meta[starts-with(@name, \'keywords\')]/@content').to_s.split(/\s*,\s*/)
  end
end

# parser = OGParser.new
# parser.parse('http://www.zeit.de/kultur/film/2017-03/dominik-wichmann-guido-westerwelle-film-zwischen-zwei-leben', 3)
#
# puts parser.get_image_uri

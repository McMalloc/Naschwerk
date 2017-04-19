# encoding=utf-8

require 'nokogiri'
require 'sequel'
# require 'Date'
require_relative '../parser/og_parser'

database = Sequel.sqlite("db/database-development.db")

class Post < Sequel::Model

end

doc = File.open(File.expand_path('googlespaces/expand.html')) { |f| Nokogiri::HTML(f) }
old_posts = doc.xpath '//*/div[starts-with(@class, \'TZN3ff\')]'
old_posts.each do |node|
  oldpost = Post.new do |p|
    parser = OGParser.new

    p.user_id = 1
    p.url = node.css('.VsqhMc a').map { |link| link['href'] }[0]

    if !p.url.nil?
      parser.parse(p.url, 2)
      p.title = parser.get_title
    end

    description = 'Ursprünglich gepostet von ' + (node.css ".W42ixb").first.content.split(/\s·\s/)[0]
    (node.css ".x099Od").each do |comment|
      description += "\n" + comment.content
    end
    p.og_description = description
    p.og_image = node.css('.VsqhMc img').map { |img| img['src'] }
    p.created_at = Date.strptime((node.css ".W42ixb").first.content.split(/\s·\s/)[1], "%d.%m.%Y").strftime('%Y-%m-%d %H:%M:%S')
  end
  begin
    oldpost.save
  rescue
    puts "error saving record"
    puts oldpost.url
  end
end



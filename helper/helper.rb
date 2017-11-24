require 'net/smtp'
require 'net/http'
require 'open-uri'

class Naschwerk < Sinatra::Base
  helpers do

    def normalize_uri(uri)
      return uri if uri.is_a? URI

      uri = uri.to_s
      uri, *tail = uri.rpartition "#" if uri["#"]

      URI(URI.encode(uri) << Array(tail).join)
    end

#     def feedback_mail (content, user)
#       message = "
# From: #{user} <naschwerk feedback form>
# To: Webmaster <naschwerk@sushi-schranke.de>
# Subject: Naschwerk Feedback\n
# #{content}"
#
#       Net::SMTP.start('suhail.uberspace.de',
#                       587,
#                       'naschwerk.sushi-schranke.de',
#                       'naschwerk@svickova.suhail.uberspace.de', 'naschwerk00', :login) do |smtp|
#         smtp.enable_starttls_auto
#         smtp.send_message message,  'naschwerk@svickova.suhail.uberspace.de',
#                                     ['naschwerk@sushi-schranke.de']
#       end
#     end

    # def broadcast_mail (link, subject, title)
    #   # @link = link
    #   # @subject = subject
    #   # @title = title
    #   # message = slim :email_new_post, layout: false
    #   message = "
    #       From Naschwerk
    #       To Naschwerkabonnent
    #       Subject #{subject}
    #
    #       Hi,
    #
    #       #{title}
    #       #{link}
    #
    #       Gruß
    #   "
    #   addrs = []
    #   User.each do |user|
    #     unless user.email.nil? || (user.email.length == 0)
    #       addrs.push user.email
    #     end
    #   end
    #   puts addrs
    #   Net::SMTP.start('suhail.uberspace.de',
    #                   587,
    #                   'naschwerk.sushi-schranke.de',
    #                   'naschwerk@svickova.suhail.uberspace.de', 'naschwerk00', :login) do |smtp|
    #     smtp.enable_starttls_auto
    #     smtp.send_message message,  'naschwerk@svickova.suhail.uberspace.de',
    #                       addrs
    #   end
    # end

    def get_extension imagedata
      if imagedata.encoding.ascii_compatible?
        if imagedata[0..2] == "\xFF\xD8\xFF"
          return "jpg"
        end
        if imagedata[0..2] == "GIF"
          return "gif"
        end
        if imagedata[0..7] == "\x89\x50\x4e\x47\x0d\x0a\x1a\x0a"
          return "png"
        end
      end
    end

    # def resizeAndSaveImage (imagedata, local_path, local_filename)
    #   file = File.new(local_path + local_filename, "w+")
    #   file << imagedata
    #   file.close
    #   # FastImage.resize(
    #   #   local_path + local_filename,
    #   #   100, 20,
    #   #   outfile: local_path + 'thumb_' + local_filename
    #   # )
    # end
  end

end

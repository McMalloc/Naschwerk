# require 'fastimage_resize'
require 'pony'

class Naschwerk < Sinatra::Base
  helpers do

    def broadcast_mail content, subject
      User.each do |user|
        unless user.email.nil? || (user.email.length == 0)
          Pony.mail to: user.email,
                    from: "Naschwerk",
                    subject: subject,
                    body: content,
                    via: :smtp,
                    via_options: {
                      address:              'suhail.uberspace.de',
                      port:                 '587',
                      # enable_starttls_auto: true,
                      user_name:            'naschwerk@svickova.suhail.uberspace.de',
                      password:             '',
                      authentication:       :login, # :plain, :login, :cram_md5, no auth by default
                      domain:               'suhail.uberspace.de'
                  }
        end
      end
    end

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

    def resizeAndSaveImage (imagedata, local_path, local_filename)
      file = File.new(local_path + local_filename, "w+")
      file << imagedata
      file.close
      # FastImage.resize(
      #   local_path + local_filename,
      #   100, 20,
      #   outfile: local_path + 'thumb_' + local_filename
      # )
    end
  end

end

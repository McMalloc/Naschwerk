# require 'fastimage_resize'
require 'pony'

puts Pony.mail to: 'Robert.Wlcek@student.iwid.hs-magdeburg.de',
          from: "Naschwerk",
          subject: "subject",
          body: "content",
          via: :smtp,
          via_options: {
            address:              'suhail.uberspace.de',
            port:                 '587',
            enable_starttls_auto: true,
            user_name:            'naschwerk@svickova.suhail.uberspace.de',
            password:             'kuckien0',
            authentication:       :login, # :plain, :login, :cram_md5, no auth by default
            domain:               "localhost.localdomain"
          }

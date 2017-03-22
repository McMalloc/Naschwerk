# encoding: UTF-8

class Naschwerk < Sinatra::Base
  get '/ngpartials/:name' do |name|
    slim name.to_sym, layout: false
  end
end
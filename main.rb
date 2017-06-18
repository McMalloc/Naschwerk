# encoding: UTF-8

require 'sinatra'
require 'slim/include'
require 'sinatra/config_file'

class Naschwerk < Sinatra::Base
  enable :sessions, :logging
  set :sessions, expire_after: 60*60*24*356 # 1 year
  # set :bind, '192.168.178.117'

  register Sinatra::ConfigFile
  config_file 'config.yml'
  ENV['TZ'] = 'Europe/Berlin'

  before do
    @user = User[session[:id]]
    @host = request.host + ':9292'
    @action = request.path_info
  end
end

require_relative 'routes/app_routes'

require_relative 'helper/helper'

require_relative 'routes/user_routes'
require_relative 'routes/post_routes'
require_relative 'routes/comment_routes'
# require_relative 'routes/ngpartials_routes'
require_relative 'models/init'

require_relative 'notifier/schedule'

# encoding: UTF-8
require 'sinatra'
require 'slim/include'

class Naschwerk < Sinatra::Base
  enable :sessions, :logging
  # set :bind, '192.168.178.117'

  register do
    def auth (type)
      condition do
        redirect "/login" unless send("is_#{type}?")
      end
    end
  end

  helpers do
    def is_user?
      !@user.nil?
    end
  end

  before do
    @user = User[session[:id]]
    @host = request.host
    @action = request.path_info
  end

  get '/', :auth => :user do
    # @posts = Post.all
    @posts = Post.order(Sequel.desc(:created_at)).left_join(:users, :id=>:user_id)
    slim :index
  end

  get '/dev', :auth => :user do
    slim :dev
  end

  get '/posting', :auth => :user do
    slim :posting
  end

  get '/signup' do
    slim :signup
  end

  get '/login' do
    slim :login
  end

  post '/auth' do
    @user = User[name: params[:name]]
    if !@user.nil? && @user.auth(params[:pwd])
      session[:id] = @user.id
      redirect to('/')
    else
      redirect to('/failed')
    end
  end

  get '/failed' do
    "wrong credentials"
  end
end

require_relative 'helper/helper.rb'

require_relative 'routes/user_routes'
require_relative 'routes/post_routes'
require_relative 'routes/ngpartials_routes'
require_relative 'models/init'

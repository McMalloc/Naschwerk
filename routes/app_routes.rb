# encoding: UTF-8

class Naschwerk < Sinatra::Base
  def app
    Naschwerk.new!
  end

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

  get '/', :auth => :user do
    @posts = Post
               .limit(12)
               .order(Sequel.desc(:created_at))
               .select_append(:posts__created_at___date)
               .select_append(:posts__id___post_id)
               .left_join(User.select(:id, :name), :id=>:user_id)
    slim :index
  end

  get '/dev', :auth => :user do
    slim :dev
  end

  get '/signout' do
    session[:id] = nil
    redirect '/'
  end

  post '/feedback' do
    @user = User[session[:id]]
    app.feedback_mail params['content'], params['name']
    redirect '/dev'
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

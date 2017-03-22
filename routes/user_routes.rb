# encoding: UTF-8
require 'digest'

class Naschwerk < Sinatra::Base
  get "/users" do
    User.all.to_json
  end

  get '/users/:id' do
    if @user.nil?
      redirect '/'
    end
    if @user.id == params['id'].to_i
      slim :user
    else
      redirect '/'
    end
  end

  post '/users' do
    salt = ('a'..'z').to_a.shuffle[0,8].join
    pwdhash = Digest::SHA256.hexdigest(params['pwd']+salt)

    @new_user = User.create(
        name: params['name'],
        email: params['email'],
        pwdhash: pwdhash,
        salt: salt,
        created_at: Time.now.strftime('%Y-%m-%d %H:%M:%S')
    )
    @new_user.save
    session[:id] = @new_user.id

    @new_user.to_json

    # AJAX style
    # payload = JSON.parse request.body.read
    # salt = ('a'..'z').to_a.shuffle[0,8].join
    # pwdhash = Digest::SHA256.hexdigest(payload['pwd']+salt)
    #
    # @new_user = User.create(
    #     name: payload['name'],
    #     email: payload['email'],
    #     pwdhash: pwdhash,
    #     salt: salt,
    #     created_at: Time.now.strftime('%Y-%m-%d %H:%M:%S')
    # )
    # @new_user.save
    # session[:id] = @new_user.id
    #
    # @new_user.to_json
    redirect '/'
  end
end
# encoding: UTF-8

class Naschwerk < Sinatra::Base
  get '/posts' do
    Post.all.to_json
  end

  get '/posts/:id' do
    Post[params['id'].to_i].to_json
  end

  post '/posts' do
    @user = User[session[:id]]
    if request.accept? 'text/html'

      @new_post = Post.new do |p|
          p.title = params['title']
          p.user_id = @user.id
          p.url = params['url']
          p.created_at = Time.now.strftime('%Y-%m-%d %H:%M:%S')
      end

      @new_post.gather_tags
      @new_post.save
      # @new_post.load_image
      redirect to('/')
    end

    if (request.accept? 'application/json') || (request.accept? 'text/json')
      payload = JSON.parse request.body.read
      @new_post = Post.create(
                         title: payload['title'],
                         url: payload['url'],
                         user_id: @user.id,
                         created_at: Time.now.strftime('%Y-%m-%d %H:%M:%S')
      )
      @new_post.to_json
    end
  end
end

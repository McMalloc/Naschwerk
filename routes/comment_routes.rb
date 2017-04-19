# encoding: UTF-8

class Naschwerk < Sinatra::Base

  get '/comments/:id' do
    @user = User[session[:id]]
    if @user.nil?
      redirect '/'
    else
      @comments = Comment.where(post_id: params[:id])
                    .order(Sequel.desc(:created_at))
                    .left_join(User.select(:id, :name), :id=>:user_id)
      slim :comments, layout: false
    end
  end

  post '/comments' do
    @user = User[session[:id]]
    if @user.nil?
      redirect '/'
    end

    @new_comment = Comment.create(
      content: params['content'],
      post_id: params['post_id'],
      # image_url: payload['post_id'],
      user_id: @user.id,
      created_at: Time.now.strftime('%Y-%m-%d %H:%M:%S')
    )
    @new_comment.save
    @new_comment.to_json
  end
end

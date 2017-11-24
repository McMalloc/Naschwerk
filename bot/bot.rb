require 'net/http'
require 'json'

class Naschwerk < Sinatra::Base

    post '/naschbot' do
      data = JSON.parse( request.body.read.to_s )
      # puts data
      @message = data['message']['text']
      # @user = data['message']['from']['first_name'] + data['message']['from']['last_name']
      # @message = '@naschbot Titel der es in sich hat  https://waitbutwhy.com/2017/04/neuralink.html#part3'
      # puts @message
      @mention = @message.scan(/@\w+/)
      @url = @message.scan(/https?:\/\/[\S]+/)
      @message.slice! @mention.first
      @message.slice! @url.first
      @message.strip!

      if @url.length > 0 && @message.length > 0
        @new_post = Post.new do |p|
          p.title = @message
          p.user_id = settings.TELEGRAM_USER_ID
          p.url = @url.first
          p.created_at = Time.now.strftime('%Y-%m-%d %H:%M:%S')
        end

        @new_post.gather_tags
        @new_post.save
        status 202
      else
        status 400
      end

    end

    def app
      Naschwerk.new!
    end

    def broadcast_telegram link, subject

      @message = "#{subject}
        #{URI.encode(link)}"

      @chat_id = settings.CHAT_ID
      @token = settings.TELEGRAM_API_KEY
      @uri = URI(app.normalize_uri("https://api.telegram.org/bot#{@token}/sendMessage?chat_id=#{@chat_id}&text=#{@message}"))
      Net::HTTP.get(@uri)
    end

end

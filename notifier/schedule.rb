require 'rufus-scheduler'

class Naschwerk < Sinatra::Base
  check_subs = Rufus::Scheduler.new

  check_subs.every '3h' do
    @token = settings.TELEGRAM_API_KEY
    @updates = JSON.parse URI.parse("https://api.telegram.org/bot#{@token}/getUpdates").read
    @chats = @updates['result'].map { |h| h['message']['chat']['id'] }.uniq
    @chats.each do |chat_id|
      if !Subscription.all.map { |s| s.chat_id }.include? chat_id.to_s
        @newsub = Subscription.create(
          chat_id: chat_id,
          created_at: Time.now.strftime('%Y-%m-%d %H:%M:%S')
        )
        @newsub.save
      end
    end
  end
end

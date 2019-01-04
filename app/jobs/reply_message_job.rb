class ReplyMessageJob < ApplicationJob
  queue_as :default

  def perform(event_id)
    event = Event.find_by(id: event_id)
    return if event.nil?

    message = {
      type: 'text',
      text: event.message
    }
    response = client.reply_message(event.reply_token, message)
    pp event
    pp response.body
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = '17c2cf1210359c88717382639af3a254'
      config.channel_token = '+dzgFDh3k+POoBx/h/d6i2nu6bCMHRQw1bu3pYHxpdMW+KHTfAhzbI7TF0K4RSidsW3Zal71Iw3tQ+U4NEZ3ycKYyxVLypDt6j9xVUHVC3thnxD8cR27jIKatJAnOIU+IpGeZdWfY7BAm80p1OJCPQdB04t89/1O/w1cDnyilFU='
    end
  end

end

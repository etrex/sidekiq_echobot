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
      config.channel_secret = 'f33d45875141b3f6487e924ffb56cc6f'
      config.channel_token = '7FZ71IX0suKIqsSy4MKqjKB7mHrhdsjj6Q4OicDyukDI6nANs75LBTeow1SsYhZ6Pxs/eTAkcKqAqnXg/9y1xWiLzpyS38+46jlkqJTNMnxuHUzmXGAUpoDEDbYDU/Rp35QeD3TVv5MTzCzXfIvNmAdB04t89/1O/w1cDnyilFU='
    end
  end

end

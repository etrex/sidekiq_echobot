require 'line/bot'

class ApiController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    body = request.body.read
    line_events = client.parse_events_from(body)
    events = Event.creaete_from_line_events(line_events)
    events.each do |event|
      ReplyMessageJob.perform_later event.id
    end
    head :ok
  end

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = 'f33d45875141b3f6487e924ffb56cc6f'
      config.channel_token = '7FZ71IX0suKIqsSy4MKqjKB7mHrhdsjj6Q4OicDyukDI6nANs75LBTeow1SsYhZ6Pxs/eTAkcKqAqnXg/9y1xWiLzpyS38+46jlkqJTNMnxuHUzmXGAUpoDEDbYDU/Rp35QeD3TVv5MTzCzXfIvNmAdB04t89/1O/w1cDnyilFU='
    end
  end

end

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
      config.channel_secret = '17c2cf1210359c88717382639af3a254'
      config.channel_token = '+dzgFDh3k+POoBx/h/d6i2nu6bCMHRQw1bu3pYHxpdMW+KHTfAhzbI7TF0K4RSidsW3Zal71Iw3tQ+U4NEZ3ycKYyxVLypDt6j9xVUHVC3thnxD8cR27jIKatJAnOIU+IpGeZdWfY7BAm80p1OJCPQdB04t89/1O/w1cDnyilFU='
    end
  end

end

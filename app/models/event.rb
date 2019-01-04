class Event < ApplicationRecord
  self.inheritance_column = :etype
  def self.creaete_from_line_events(line_events)
    line_events.map do |event|
      Event.create_from_line_event(event)
    end
  end

  def self.create_from_line_event(event)
    Event.create(
      channel_id: event['source']['groupId'] || event['source']['roomId'] || event['source']['userId'],
      user_id: event['source']['user_id'],
      type: event['type'],
      message: event.message['text'] || event['type'],
      reply_token: event['replyToken']
    )
  end
end

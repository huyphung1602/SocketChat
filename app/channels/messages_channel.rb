class MessagesChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "my_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # note it's 'receive', not 'received'
  def receive(data)
    Rails.logger.info("MessagesChannel got: #{data.inspect}")
    ActionCable.server.broadcast("my_channel", data)
  end

end

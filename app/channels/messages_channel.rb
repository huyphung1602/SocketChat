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

  def create(data)
    @message = Message.create(data['message'])

    if @message.persisted?
      ActionCable.server.broadcast("my_channel", message: render_message(@message))
    end
  end

  private

    def render_message(message)
      ApplicationController.render(partial: 'messages/message',
                                   locals: {message: message})
    end
end

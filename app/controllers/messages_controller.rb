class MessagesController < ApplicationController
  def index
    @messages = Message.order(created_at: 'DESC')
  end

  def create
    @message = Message.new message_params

    if @message.save
      flash[:success] = "Message sent successfully"
      ActionCable.server.broadcast("my_channel", message: render_message(@message))
      redirect_to root_path
    else
      flash[:error] = "Error #{@message.errors.full_mesages.to_sentence}"
      redirect_to root_path
    end
  end

  private
    def render_message(message)
      ApplicationController.render(partial: 'messages/message',
                                   locals: {message: message})
    end

    def message_params
      params.require(:message).permit(:body)
    end
end

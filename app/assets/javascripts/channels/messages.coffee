App.messages = App.cable.subscriptions.create "MessagesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log("MessagesChannel is connected")

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log("client receives ", data)
    
    if (data.action == 'delete')
      $("#message_" + data.messageId).remove()
    else
      $(".messages").prepend(data.message)

  create: (user_input) ->
    @perform("create", message: user_input)

  delete: (messageId) ->
    @perform("delete", messageId: messageId)

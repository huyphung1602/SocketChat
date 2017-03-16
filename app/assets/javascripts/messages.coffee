$(document).on "turbolinks:load", ->
  $("#js-socket").submit (event) ->
    console.log("stopping submitting via HTTP")
    event.preventDefault()

    # use jQuery to find the text input:
    $input = $(this).find("textarea")

    user_input = {body: $input.val()}
    console.log("sending over socket: ", user_input)
    App.messages.create(user_input)

    # clear text field
    $input.val('')
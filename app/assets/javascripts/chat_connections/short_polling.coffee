checkNewMessages = (lastCheckDate) ->
  $.get "/messages?lastCheck=#{lastCheckDate}", (data) ->
    console.log(data)
    data.forEach( (item, i, arr) ->
      displayMessage(item)
    )
    refreshChat()

refreshChat = () ->
  setTimeout ( ->
    checkNewMessages(new Date().toISOString())
  ), 5000

displayMessage = (message) ->
  $messageContainer = $('#messageContainer').clone()
  fillMessage($messageContainer, message)
  $messageContainer.removeAttr('id')
  $('#chatContainer').append($messageContainer)
  $messageContainer.toggle(400)

fillMessage = (container, message) ->
  container.find('#messageId').html(message.id)
  container.find('#username').html(message.username)
  container.find('#message').html(message.content)
  container

ready = ->
  $('#new_message').on 'ajax:success', ->
    $('#message_content').val('')

  refreshChat()

$(document).ready(ready)
$(document).on('page:load', ready)

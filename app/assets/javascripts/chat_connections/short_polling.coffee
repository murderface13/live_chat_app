refreshInterval = 5000

checkNewMessages = (lastCheckDate) ->
  $.get "/messages?lastCheck=#{lastCheckDate}&interval=#{refreshInterval/1000}", (data) ->
    data.forEach((item, i, arr) ->
      return if $("#message_#{item.id}").length > 0
      displayMessage(item)
    )

displayMessage = (message) ->
  $messageContainer = $('#messageContainer').clone()
  $messageContainer.removeAttr('id')
  fillMessage($messageContainer, message)
  $('#chatContainer').append($messageContainer)
  $messageContainer.show(400)

fillMessage = (container, message) ->
  messageId = "message_#{message.id}"
  container.attr('id',"#{messageId}")
  container.find('#username').html(message.username+': ')
  container.find('#message').html(message.content)
  container

ready = ->
  $('#new_message').on 'ajax:success', ->
    checkNewMessages(new Date().toISOString())
    $('#message_content').val('')

  setInterval ( ->
    checkNewMessages(new Date().toISOString())
  ), refreshInterval

$(document).ready(ready)
$(document).on('page:load', ready)

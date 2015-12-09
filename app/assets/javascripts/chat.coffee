ready = ->
  window.displayChatMessage = (message) ->
    return if $("##{messageFieldId(message.id)}").length > 0
    $container = blankMessageContainer()
    $container = fillMessage($container, message)
    showContainer($container)

  messageFieldId = (id) ->
    "message_#{id}"

  blankMessageContainer = ->
    $messageContainer = $('#messageContainer').clone()
    $messageContainer.removeAttr('id')
    $messageContainer

  fillMessage = (container, message) ->
    container.attr('id', messageFieldId(message.id))
    container.find('#username').html(message.username+': ')
    container.find('#message').html(message.content)
    container

  showContainer = (container) ->
    $('#chatContainer').append(container)
    container.show(400)

  $('#new_message').on 'ajax:success', ->
    $('#message_content').val('')

$(document).ready(ready)
$(document).on('page:load', ready)

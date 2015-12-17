# that module needs to displaying chat messages on page:load
# use displayChatMessage method to show new chat message
# message needs contain user_id, username and message content

ready = ->
  window.displayChatMessage = (message) ->
    return if $("##{messageFieldId(message.id)}").length > 0
    $container = blankMessageContainer()
    $container = fillMessage($container, message)
    showContainer($container)

  # we need lastId method as global,
  # because pollings code use that method to send last id to server
  window.lastId = ->
    allMessages = $('.message')
    # we use length < 2 because allMessages.length will always
    # be 1 - we have message container with class .message
    return 0 if allMessages.length < 2
    # we use split, because message id is like 'message_123'
    allMessages[allMessages.length - 2].id.split('_')[1]

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
    container.addClass('own') if message.username == current_username
    container

  showContainer = (container) ->
    $('#chatContainer').append(container)
    container.slideToggle(400)

  # clear message input after success form submit
  $('#new_message').on 'ajax:success', ->
    $('#message_content').val('')

$(document).ready(ready)
$(document).on('page:load', ready)

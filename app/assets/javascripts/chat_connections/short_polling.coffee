refreshInterval = 5000

checkNewMessages = ->
  $.get "/messages?lastId=#{lastId()}", (data) ->
    data.forEach( (item) ->
      displayChatMessage(item)
    )

ready = ->
  # chech new messages for show new message after form submit
  $('#new_message').on 'ajax:success', ->
    checkNewMessages()

  setInterval ( ->
    checkNewMessages()
  ), refreshInterval

$(document).ready(ready)
$(document).on('page:load', ready)

checkNewMessages = ->
  $.get "/messages?lastId=#{lastId()}", (data) ->
    data.forEach( (item) ->
      displayChatMessage(item)
    )
    checkNewMessages()

ready = ->
  checkNewMessages()

$(document).ready(ready)
$(document).on('page:load', ready)

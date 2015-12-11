ready = ->
  checkNewMessages = ->
    $.get "/messages?lastId=#{lastId()}", (data) ->
      data.forEach((item, i, arr) ->
        displayChatMessage(item)
      )
      checkNewMessages()

  checkNewMessages()


$(document).ready(ready)
$(document).on('page:load', ready)

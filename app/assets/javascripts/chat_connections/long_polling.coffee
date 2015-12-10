ready = ->
  checkNewMessages = ->
    $.get "/messages", (data) ->
      data.forEach((item, i, arr) ->
        displayChatMessage(item)
      )
      checkNewMessages()

  checkNewMessages()


$(document).ready(ready)
$(document).on('page:load', ready)

ready = ->
  source = new EventSource('/messages/events')
  source.onmessage = (e) ->
    message = JSON.parse(e.data)
    displayChatMessage(message)

$(document).ready(ready)
$(document).on('page:load', ready)

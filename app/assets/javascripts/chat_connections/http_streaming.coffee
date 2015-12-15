ready = ->
  source = new EventSource('/messages/events')
  source.addEventListener 'messages.create', (e) ->
    alert(parseJSON(e.data))
  console.log(source)

$(document).ready(ready)
$(document).on('page:load', ready)

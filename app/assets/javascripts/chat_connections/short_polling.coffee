refreshInterval = 5000

checkNewMessages = (lastCheckDate) ->
  $.get "/messages?lastId=#{lastId()}", (data) ->
    data.forEach((item, i, arr) ->
      displayChatMessage(item)
    )

ready = ->
  $('#new_message').on 'ajax:success', ->
    checkNewMessages(new Date().toISOString())

  setInterval ( ->
    checkNewMessages(new Date().toISOString())
  ), refreshInterval

$(document).ready(ready)
$(document).on('page:load', ready)

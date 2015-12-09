refreshInterval = 5000

checkNewMessages = (lastCheckDate) ->
  refreshInSeconds = refreshInterval / 1000
  $.get "/messages?lastCheck=#{lastCheckDate}&interval=#{refreshInSeconds}", (data) ->
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

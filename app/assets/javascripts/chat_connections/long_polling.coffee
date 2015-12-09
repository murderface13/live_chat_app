refreshInterval = 5000

checkNewMessages = (lastCheckDate) ->
  refreshInSeconds = refreshInterval / 1000
  $.get "/messages?lastCheck=#{lastCheckDate}&interval=#{refreshInSeconds}", (data) ->
    data.forEach((item, i, arr) ->
      displayChatMessage(item)
    )
    checkNewMessages(new Date().toISOString())

# lastId = ->
#   allMessages = $('.message')
#   allMessages[allMessages.length - 2].id.split('_')[1]

ready = ->
  checkNewMessages(new Date().toISOString())


$(document).ready(ready)
$(document).on('page:load', ready)

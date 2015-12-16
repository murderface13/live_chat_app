#= require cable

@App = {}
App.cable = Cable.createConsumer 'ws://' + window.location.host + '/websocket'
App.messages = App.cable.subscriptions.create 'MessagesChannel',
  received: (data) ->
    displayChatMessage(data)

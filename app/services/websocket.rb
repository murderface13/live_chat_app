module Websocket
  class << self
    def publish(message)
      ActionCable.server.broadcast('messages', message_to_hash(message))
    end

    private

    def message_to_hash(message)
      {
        id: message.id,
        username: message.username,
        content: message.content
      }
    end
  end
end

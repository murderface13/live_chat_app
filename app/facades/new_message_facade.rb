require 'streamer/sse'

# MessagesFacade needs to declare control to destination classes
# depends on connection method - http streaming or websocket
class NewMessageFacade
  def initialize(connection, stream)
    @connection = connection
    @sse = Streamer::SSE.new(stream)
    @websocket = Websocket
  end

  def publish(message)
    case @connection
    when 'http streaming'
      @sse.publish(message)
    when 'web socket'
      @websocket.publish(message)
    end
  end

  def subscribe!
    @sse.subscribe
  end
end

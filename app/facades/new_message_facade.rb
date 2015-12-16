require 'streamer/sse'

class NewMessageFacade
  def initialize(connection, stream)
    @connection = connection
    @sse = Streamer::SSE.new(stream)
  end

  def publish(message)
    case @connection
    when 'http streaming'
      @sse.publish(message)
    end
  end

  def subscribe
    @sse.subscribe
  end
end

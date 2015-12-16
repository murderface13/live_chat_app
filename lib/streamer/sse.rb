require 'json'

module Streamer
  class SSE
    def initialize(stream)
      @stream = stream
    end

    def subscribe
      redis = Redis.new
      redis.subscribe('live_chat_app:messages.create') do |on|
        on.message do |_, data|
          @stream.write("data: #{data}\n\n")
        end
      end
    rescue IOError
      logger.info 'Stream closed'
    ensure
      redis.quit
      @stream.close
    end

    def publish(message)
      $redis.publish('messages.create', message.to_json)
    end
  end
end

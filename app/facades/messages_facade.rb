require 'polling/short_polling'
require 'polling/long_polling'

class MessagesFacade
  attr_reader :connection

  CHAT_HISTORY_LENGTH = 5

  def initialize(connection, last_message_id)
    @connection = connection
    @last_id = last_message_id
    @short_polling = ShortPolling
    @long_polling = LongPolling
  end

  def recent_messages
    case @connection
    when 'short polling'
      @short_polling.recent_messages(@last_id)
    when 'long polling'
      @long_polling.recent_messages(@last_id)
    when nil
      fail ArgumentError, 'Connection type was not set'
    else
      fail NoMethodError, 'There are no defined recent_messages method for chat connection type:' + @connection
    end
  end

  private

  def last_id(id)
    int_id = id.to_i
    int_id == 0 ? $redis['last_message_id'].to_i - CHAT_HISTORY_LENGTH : int_id
  end
end

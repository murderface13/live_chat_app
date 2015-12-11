class ChatFacade
  attr_reader :connection

  def initialize(connection, last_message_id)
    @connection = connection
    @last_id = last_id(last_message_id)
  end

  def recent_messages
    case @connection
    when 'short polling'
      last_messages
    when 'long polling'
      long_poll
    when nil
      fail ArgumentError, 'Connection type was not set'
    else
      fail NoMethodError, 'There are no defined recent_messages method for chat connection type:' + @connection
    end
  end

  private

  def last_id(id)
    int_id = id.to_i
    int_id == 0 ? $redis['last_message_id'].to_i - 5 : int_id
  end

  def last_messages
    messages = JSON.parse($redis['last_messages'])
    last_messages = []
    messages.each do |message|
      last_messages << message if message['id'] > @last_id
    end
    last_messages
  end

  def long_poll
    new_messages = []
    10.times do
      new_messages = last_messages
      return new_messages if new_messages.any?
      sleep 5
    end
    new_messages
  end
end

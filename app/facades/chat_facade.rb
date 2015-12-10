class ChatFacade
  attr_reader :connection

  def initialize(connection)
    @connection = connection
    @last_id = last_id
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

  def last_id
    Message.last.id
  end

  def last_messages
    Message.where('id > ?', @last_id).compact
  end

  def long_poll
    new_messages = []
    10.times do
      ActiveRecord::Base.clear_all_connections!
      new_messages = last_messages
      return new_messages if new_messages.any?
      sleep 1
    end
    new_messages
  end
end

class ChatFacade
  attr_reader :connection

  def initialize(connection)
    @connection = connection
  end

  # TODO: refactor getting recent messages by ids
  def recent_messages(last_check_date)
    case @connection
    when 'short polling'
      recent_messages_from(last_check_date)
    when 'long polling'
      long_poll(last_check_date)
    when nil
      fail ArgumentError, 'Connection type was not set'
    else
      fail NoMethodError, 'There are no defined recent_messages method for chat connection type:' + @connection
    end
  end

  private

  def recent_messages_from(last_check_date)
    Message.recent_from(last_check_date).compact
  end

  def long_poll(last_check_date)
    10.times do
      ActiveRecord::Base.clear_all_connections!
      new_messages = recent_messages_from(last_check_date)
      puts "======LAST MESSAGE CREATED AT #{Message.last.created_at}======"
      return new_messages if new_messages.any?
      sleep 3
    end
  end
end

class ChatFacade
  attr_reader :connection

  def initialize(connection)
    @connection = connection
  end

  def recent_messages(last_check_date)
    case @connection
    when 'short polling'
      Message.recent(last_check_date).compact
    when nil
      fail ArgumentError, 'Connection type was not set'
    else
      fail NoMethodError, 'There are no defined recent_messages method for chat connection type:' + @connection
    end
  end
end

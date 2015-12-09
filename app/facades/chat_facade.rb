class ChatFacade
  attr_reader :connection

  def initialize(connection)
    @connection = connection
  end

  def recent_messages(last_check_date)
    case @connection
    when 'short polling'
      Message.where('created_at >= ?', last_check_date)
    when nil
      fail ArgumentError, 'Connection type was not set'
    else
      fail NoMethodError, 'There are no defined recent_messages method for chat connection type:' + @connection
    end
  end
end

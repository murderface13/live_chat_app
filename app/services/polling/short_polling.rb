require 'polling/polling_base'

class ShortPolling < Polling::Base
  class << self
    def recent_messages(last_message_id)
      messages_after_id(last_message_id)
    end
  end
end

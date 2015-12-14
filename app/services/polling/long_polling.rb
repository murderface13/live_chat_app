require 'polling/polling_base'

class LongPolling < Polling::Base

  REPEAT_TIMES = 10
  SLEEP_TIME   = 5

  class << self
    def recent_messages(id)
      new_messages = []
      REPEAT_TIMES.times do
        new_messages = messages_after_id(id)
        return new_messages if new_messages.any?
        sleep SLEEP_TIME
      end
      new_messages
    end
  end
end

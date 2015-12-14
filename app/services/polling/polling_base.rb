module Polling
  class Base
    class << self
      protected

      def messages_after_id(last_message_id)
        messages = JSON.parse($redis['last_messages'])
        last_messages = []
        messages.each do |message|
          last_messages << message if message['id'] > last_id(last_message_id)
        end
        last_messages
      end

      private

      def last_id(id)
        int_id = id.to_i
        int_id == 0 ? $redis['last_message_id'].to_i - 5 : int_id
      end
    end
  end
end

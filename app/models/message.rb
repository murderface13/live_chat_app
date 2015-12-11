class Message < ActiveRecord::Base
  scope :recent_from, lambda { |last_check_date| where('created_at >= ?', last_check_date) }
  scope :compact, -> { select(:id, :content, :username) }

  after_create :cache_last_messages

  private

  def cache_last_messages
    last_messages = Message.last(20).compact
    $redis.set('last_messages', last_messages.to_json)
    $redis.set('last_message_id', last_messages.last.id)
  end
end

class Message < ActiveRecord::Base
  scope :recent, lambda { |last_check_date| where('created_at >= ?', last_check_date) }
  scope :compact, -> { select(:id, :content, :username) }
end

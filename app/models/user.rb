class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username,
            presence: true,
            uniqueness: {
              case_sensitive: false
            }

  # TODO: move to Chatable module
  CHAT_CONNECTION_METHODS = [
    'short polling',
    'long polling',
    'http streaming'
  ]

  after_save :invalidate_cache
  def self.serialize_from_session(key, salt)
    single_key = key.is_a?(Array) ? key.first : key
    Rails.cache.fetch("user:#{single_key}") do
       User.where(:id => single_key).entries.first
    end
  end


  def email_required?
    false
  end

  def email_changed?
    false
  end

  private
    def invalidate_cache
      Rails.cache.delete("user:#{id}")
    end
end

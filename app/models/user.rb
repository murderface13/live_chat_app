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
    'long polling'
  ]

  def email_required?
    false
  end

  def email_changed?
    false
  end
end

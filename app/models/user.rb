class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # TODO: move to Chatable module
  CHAT_CONNECTION_METHODS = [
    'short polling',
    'long polling'
  ]
end

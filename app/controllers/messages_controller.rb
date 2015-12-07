class MessagesController < ApplicationController
  def create
    message = Message.create(message_params)
    render nothing: true
  end

  def index
    last_check_date = Time.parse(params[:lastCheck]).utc
    new_messages = Message.where('created_at >= ?', last_check_date)
    render nothing: true
  end

  private

  def message_params
    params[:message].permit!
  end  
end

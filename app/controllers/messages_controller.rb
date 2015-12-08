class MessagesController < ApplicationController
  def create
    message = Message.create(message_params)
    render nothing: true
  end

  def index
    last_check_date = Time.parse(params[:lastCheck])
    # it assumes that short polling interval is 5 seconds
    polling_interval = 5
    last_check_date -= polling_interval.seconds
    new_messages = Message.where('created_at >= ?', last_check_date)
    render json: new_messages.to_json
  end

  private

  def message_params
    strong_message_params = params[:message]
    strong_message_params[:username] = current_user.username
    strong_message_params.permit!
  end
end

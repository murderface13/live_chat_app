class MessagesController < ApplicationController

  before_action :init_response_processor, only: [:index]

  def create
    message = Message.create(message_params)
    status = message.errors.any? ? 500 : 204
    render nothing: true, status: status
  end

  def index
    recent_messages = @response_processor.recent_messages(last_check_date)
    render json: recent_messages.to_json
  end

  private

  def last_check_date
    last_check_date = Time.parse(params[:lastCheck])
    polling_interval = params[:interval].to_i
    last_check_date - polling_interval.seconds
  end

  def message_params
    strong_message_params = params[:message]
    strong_message_params[:username] = current_user.username
    strong_message_params.permit!
  end

  def init_response_processor
    @response_processor = ChatFacade.new(session[:connection_method])
  end
end

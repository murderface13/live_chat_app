class MessagesController < ApplicationController
  include ActionController::Live

  before_action :init_messages_processor, only: [:index]
  before_action :init_new_message_processor, only: [:create, :events]

  def create
    message = Message.create(message_params)
    status = message.errors.blank? ? 204 : 500
    @new_message_processor.publish(message) if message.errors.blank?
    render nothing: true, status: status
  end

  def index
    recent_messages = @messages_processor.recent_messages
    render json: recent_messages.to_json
  end

  def events
    response.headers['Content-Type'] = 'text/event-stream'
    @new_message_processor.subscribe
    render nothing: true
  end

  private

  def message_params
    strong_message_params = params[:message]
    strong_message_params[:username] = current_user.username
    strong_message_params.permit!
  end

  def init_messages_processor
    @messages_processor = MessagesFacade.new(session[:connection_method], params[:lastId])
  end

  def init_new_message_processor
    @new_message_processor = NewMessageFacade.new(session[:connection_method], response.stream)
  end
end

require 'streamer/sse'

class MessagesController < ApplicationController
  include ActionController::Live

  before_action :init_response_processor, only: [:index]

  def create
    message = Message.create(message_params)

    status = message.errors.any? ? 500 : 204
    response.headers["Content-Type"] = "text/event-stream"
    $redis.publish('messages.create', message.to_json)

    render nothing: true, status: status
  end

  def index
    # recent_messages = @response_processor.recent_messages(last_check_date)
    recent_messages = @response_processor.recent_messages
    render json: recent_messages.to_json
  end

  def events
    response.headers['Content-Type'] = "text/event-stream"
    redis = Redis.new
    redis.subscribe('live_chat_app:messages.create') do |on|
      on.message do |_, data|
        response.stream.write("data: #{data}\n\n")
      end
      on.close do
        redis.quit
      end
    end
    render nothing: true
  rescue IOError
    logger.info 'Stream closed'
  ensure
    redis.quit
    response.stream.close
  end

  private

  def message_params
    strong_message_params = params[:message]
    strong_message_params[:username] = current_user.username
    strong_message_params.permit!
  end

  def init_response_processor
    @response_processor = ChatFacade.new(session[:connection_method], params[:lastId])
  end
end

require 'streamer/sse'

class MessagesController < ApplicationController
  include ActionController::Live

  before_action :init_response_processor, only: [:index]

  def create
    message = Message.create(message_params)

    status = message.errors.any? ? 500 : 204
    $redis.publish('messages.create', message.to_json)
    binding.pry

    render nothing: true, status: status
  end

  def index
    # recent_messages = @response_processor.recent_messages(last_check_date)
    recent_messages = @response_processor.recent_messages
    render json: recent_messages.to_json
  end

  def events
    response.headers['Content-Type'] = 'text/event-stream'
    sse = Streamer::SSE.new(response.stream)
    redis = Redis.new
    redis.subscribe('messages.create') do |on|
      on.message do |event, data|
        response.stream.write("data: #{data}\n\n")
      end
    end
    render nothing: true
    rescue IOError
      # Client disconnected
    ensure
      redis.quit
      sse.close
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

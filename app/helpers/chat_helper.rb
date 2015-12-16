module ChatHelper
  def include_chat_client_code
    case session[:connection_method]
    when 'short polling'
      javascript_include_tag 'chat_connections/short_polling'
    when 'long polling'
      javascript_include_tag 'chat_connections/long_polling'
    when 'http streaming'
      javascript_include_tag 'chat_connections/http_streaming'
    when 'web socket'
      javascript_include_tag 'chat_connections/websocket'
    else
      javascript_include_tag 'chat_connections/no_connection_method'
    end
  end
end

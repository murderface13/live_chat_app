module ChatHelper
  def include_chat_client_code
    case session[:connection_method]
    when 'short polling'
      javascript_include_tag 'chat_chat_connections/short_polling'
    when 'long polling'
      javascript_include_tag 'chat_connections/long_polling'
    else
      javascript_include_tag 'chat_connections/no_connection_method'
    end
  end
end

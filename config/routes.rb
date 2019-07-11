Rails.application.routes.draw do
  def to_param
  token
  chat_number
  message_number
  end
  resources :applications do
    resources :chats  do
      resources :messages
    end
  end
end

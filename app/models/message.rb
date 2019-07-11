class Message < ApplicationRecord
  belongs_to :chat

  validates_presence_of :message_number, :body
end

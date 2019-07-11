class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages, dependent: :destroy

  validates_presence_of :chat_number
end

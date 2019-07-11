require 'rails_helper'

RSpec.describe Message, type: :model do
  # Association test
  it { should belong_to(:chat) }
  # Validation tests
  it { should validate_presence_of(:message_number) }
  it { should validate_presence_of(:body) }
end

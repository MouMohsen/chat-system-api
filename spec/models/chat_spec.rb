require 'rails_helper'

RSpec.describe Chat, type: :model do
  # Association test
  it { should belong_to(:application) }
  it { should have_many(:messages).dependent(:destroy) }
  # Validation test
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:messages_count) }
end

require 'rails_helper'

RSpec.describe 'Messages API' do
  # Initialize the test data
  let!(:application) { create(:application) }
  let!(:chat) { create(:chat, application_id: application.id) }
  let(:application_id) { application.id }

  let!(:messages) { create_list(:message, 20, chat_id: chat.id) }
  let(:chat_id) { chat.id }
  let(:id) { messages.first.id }

  # Test suite for GET /applications/:application_id/chats/:chat_id/messages
  describe 'GET /applications/:application_id/chats/:chat_id/messages' do
    before { get "/applications/#{application_id}/chats/#{chat_id}/messages" }

    context 'when chat exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all chat messages' do
        expect(json.size).to eq(20)
      end
    end

    context 'when chat does not exist' do
      let(:chat_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Chat/)
      end
    end
  end

  # Test suite for GET /applications/:application_id/chats/:chat_id/messages/:id
  describe 'GET /applications/:application_id/chats/:chat_id/messages/:id' do
    before { get "/applications/#{application_id}/chats/#{chat_id}/messages/#{id}" }

    context 'when chat message exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the message' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when chat message does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Message/)
      end
    end
  end

  # Test suite for POST /applications/:application_id/chats/:chat_id/messages
  describe 'POST /applications/:application_id/chats/:chat_id/messages' do
    let(:valid_attributes) { { number: 1, body: "Valid Body Text" } }

    context 'when request attributes are valid' do
      before { post "/applications/#{application_id}/chats/#{chat_id}/messages", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/applications/#{application_id}/chats/#{chat_id}/messages", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Number can't be blank/)
      end
    end
  end

  # Test suite for PUT /applications/:application_id/chats/:chat_id/messages/:id
  describe 'PUT /chats/:chat_id/messages/:id' do
    let(:valid_attributes) { { number: 2 } }

    before { put "/applications/#{application_id}/chats/#{chat_id}/messages/#{id}", params: valid_attributes }

    context 'when message exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the message' do
        updated_message = Message.find(id)
        expect(updated_message.number).to match(2)
      end
    end

    context 'when the message does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Message/)
      end
    end
  end

  # Test suite for DELETE /applications/:application_id/chats/:id
  describe 'DELETE /chats/:id' do
    before { delete "/applications/#{application_id}/chats/#{chat_id}/messages/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

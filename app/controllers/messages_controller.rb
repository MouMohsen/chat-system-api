class MessagesController < ApplicationController
  before_action :set_application
  before_action :set_chat
  before_action :set_chat_message, only: [:show, :update, :destroy]

  # GET /chats/:chat_id/messages
  def index
    json_response(@chat.messages)
  end

  # GET /chats/:chat_id/messages/:id
  def show
    json_response(@message)
  end

  # POST /chats/:chat_id/messages
  def create
    @chat.messages.create!(message_params)
    json_response(@chat, :created)
  end

  # PUT /chats/:chat_id/messages/:id
  def update
    @message.update(message_params)
    head :no_content
  end

  # DELETE /chats/:chat_id/messages/:id
  def destroy
    @message.destroy
    head :no_content
  end

  private

  def message_params
    params.permit(:number, :body)
  end

  def set_application
    @application = Application.find(params[:application_id])
  end

  def set_chat
    @chat = @application.chats.find_by!(id: params[:chat_id]) if @application
  end

  def set_chat_message
    @message = @chat.messages.find_by!(id: params[:id]) if @chat
  end
end

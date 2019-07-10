class ChatsController < ApplicationController
  before_action :set_application
  before_action :set_application_chat, only: [:show, :update, :destroy]

  # GET /applications/:application_id/chats
  def index
    json_response(@application.chats)
  end

  # GET /applications/:application_id/chats/:id
  def show
    json_response(@chat)
  end

  # POST /applications/:application_id/chats
  def create
    @application.chats.create!(chat_params)
    json_response(@application, :created)
  end

  # PUT /applications/:application_id/chats/:id
  def update
    @chat.update(chat_params)
    head :no_content
  end

  # DELETE /applications/:application_id/chats/:id
  def destroy
    @chat.destroy
    head :no_content
  end

  private

  def chat_params
    params.permit(:number, :messages_count)
  end

  def set_application
    @application = Application.find(params[:application_id])
  end

  def set_application_chat
    @chat = @application.chats.find_by!(id: params[:id]) if @application
  end
end

class ChatsController < ApplicationController
  before_action :set_application
  before_action :set_application_chat, only: [:show, :update, :destroy]

  # GET /applications/:application_token/chats
  def index
    json_response(@application.chats)
  end

  # GET /applications/:application_token/chats/:id
  def show
    json_response(@chat)
  end

  # POST /applications/:application_token/chats
  def create
    @chat = @application.chats.create!(chat_params)
    @application.increment!(:chats_count, 1)

    json_response(@chat, :created)
  end

  # PUT /applications/:application_token/chats/:id
  def update
    @chat.update(chat_params)
    head :no_content
  end

  # DELETE /applications/:application_token/chats/:id
  def destroy
    @chat.destroy
    @application.decrement!(:chats_count, 1)
    head :no_content
  end

  private

  def chat_params
    params.permit(:chat_number)
  end

  def set_application
    @application = Application.find_by! token: (params[:application_id])
  end

  def set_application_chat
    @chat = @application.chats.find_by!(chat_number: params[:id]) if @application
  end
end

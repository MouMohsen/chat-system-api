class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :update, :destroy]

 # GET /applications
 def index
   @applications = Application.all
   json_response(@applications)
 end

 # POST /applications
 def create
   @application = Application.create!(application_params)
   json_response(@application, :created)
 end

 # GET /applications/:id
 def show
   json_response(@application)
 end

 # PUT /applications/:id
 def update
   @application.update(application_params)
   head :no_content
 end

 # DELETE /applications/:id
 def destroy
   @application.destroy
   head :no_content
 end

 private

 def application_params
   # whitelist params
   generated_token = loop do
     token = SecureRandom.hex(10)
     break token unless Application.exists?(token: token)
   end
   params.permit(:name).merge(token: generated_token)
 end

 def set_application
   @application = Application.find_by! token: (params[:id])
 end
end

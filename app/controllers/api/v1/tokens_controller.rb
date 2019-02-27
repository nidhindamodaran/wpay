class Api::V1::TokensController < ApplicationController
  skip_before_action :authenticate_request
  
  # Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NTEzNTQ5NTh9.UwGuZZBguZN5Oyt8CGqtKhiudvTh_ds4G0Io2ge6Qa4ß
  
  def authenticate
    service_response = AuthenticateUser.call(params[:email], params[:password])
    if service_response.success?
      render json: {response: service_response.result }
    else
      render json: {errors: service_response.errors}, status: :unauthorized
    end
  end

end

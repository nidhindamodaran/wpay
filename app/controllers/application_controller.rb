class ApplicationController < ActionController::API
    before_action :authenticate_request
    attr_reader :current_user

    def authenticate_request
        service_response = AuthenticateRequest.call(request.headers)
        if service_response.success?
            @current_user = service_response.result
        else
            render json: {error: service_response.errors}
        end
    end
end

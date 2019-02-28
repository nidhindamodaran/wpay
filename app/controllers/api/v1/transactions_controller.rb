class Api::V1::TransactionsController < ApplicationController
    def create
        service_response = Pay.call(
            amount: params[:amount], 
            recipient_id: params[:recipient_id],
            current_user: current_user
        )
        if service_response.success?
            render json: service_response.result
        else
            render json:{errors: service_response.errors}
        end
        
    end
end

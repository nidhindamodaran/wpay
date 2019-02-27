class Api::V1::UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:create]

    def profile
        render json: current_user, only: [:email,:name]
    end

    def create
        user = User.new(user_params)
        if user.save
            render json: {status: 'success'}
        else
            render json: {status: 'failed', errors: user.errors}
        end
    end

    private

    def user_params
        params.require(:user).permit(:email,:name,:password)
    end
end

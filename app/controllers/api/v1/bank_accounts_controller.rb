class Api::V1::BankAccountsController < ApplicationController

    def create
        account = current_user.bank_accounts.build(bank_account_param)
        if account.save
            render json: account, only: [:name, :id, :ifsc]
        else
            render json: {status: 'failed', errors: account.errors}
        end
    end

    def primarize
        service_response = PrimarizeBankAccount.call(account_number: params[:id], current_user: current_user)
        if service_response.success?
            render json: service_response.result, only: [:name, :id, :ifsc]
        else
            render json: {errors: service_response.errors}
        end
    end

    private

    def bank_account_param
        params.require(:bank_account).permit(:ifsc, :balance, :name)
    end

end

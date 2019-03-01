class Api::V1::ScratchCardsController < ApplicationController
  def scratch
    service_reponse = ScratchTheCard.call(scratch_card_id: params[:id], current_user: current_user)
    if service_reponse.success?
      render json: service_reponse.result, only: [:amount, :created_at]
    else
      render json: {status: "failed", errors: service_reponse.errors}
    end
  end
end

class Api::PromotionsController < ApplicationController
  def index
    promotions = Promotion.search(params[:search])
    render json: promotions, include: :image, status: 200
  end
end
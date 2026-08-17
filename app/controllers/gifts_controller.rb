class GiftsController < ApplicationController
  before_action only: :show

  def index
    @gifts = Gift.alphabetical.includes(:contributions)
  end

  def show
    @gift = Gift.find(params[:slug])
  end
end

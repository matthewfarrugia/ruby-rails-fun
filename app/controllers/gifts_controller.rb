class GiftsController < ApplicationController
  def index
    @gifts = Gift.alphabetical.includes(:contributions)
  end

  def show
    @gift = Gift.find(params[:slug])
  end
end

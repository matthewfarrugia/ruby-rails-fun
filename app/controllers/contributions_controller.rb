class ContributionsController < ApplicationController
  before_action :set_gift

  def new
    @form = ContributionForm.new
  end

  def create
    @form = ContributionForm.new(contribution_params.merge(gift: @gift))
    if @form.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @gift, notice: "Thanks for contributing!" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def set_gift
      @gift = Gift.find(params[:gift_slug])
    end

    def contribution_params
      params.expect(contribution_form: [ :name, :email, :amount, :currency ])
    end
end

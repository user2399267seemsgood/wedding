class GiftsController < ApplicationController
  layout 'gifts'

  def index
    @gifts = Gift.all.order(:claimed, :name)
  end

  def claim
    @gift = Gift.find(params[:id])
    if @gift.update(claimed: true, claimer_name: params[:name], claimer_email: params[:email])
      GiftMailer.with(gift: @gift).gift_claimed_email.deliver_now
      redirect_to gifts_path, notice: "Gift claimed successfully!"
    else
      redirect_to gifts_path, alert: "Something went wrong."
    end
  end

  def gift_params
    params.require(:gift).permit(:name, :description, :image, :image_url, :buy_url, :claimed, :price_range)
  end
end


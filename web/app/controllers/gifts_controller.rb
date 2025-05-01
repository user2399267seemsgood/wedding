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

  def payment_options
    @payment_methods = [
      {
        title: 'Bargeld / Dinheiro / Cash',
        description: "An der Hochzeit, in einem Briefumschlag.\nNo casamento, dentro de um envelope.\nAt the wedding, in an envelope.",
        image: 'payment_options/cash.jpg'
      },
      {
        title: 'Bank Transfer',
        description: "Daniel Valério Sampaio\nMürtschenblick 20\n8863 Buttikon SZ\n\nIBAN: CH71 0077 7003 9371 9226 6",
        image: 'payment_options/szkb.jpg'
      },
      {
        title: 'TWINT',
        description: "Benutze dazu unsere Telefonnummern.\nUsando os nossos números de telefone.\nUsing our phone numbers.",
        image: 'payment_options/twint.png'
      },
      {
        title: 'PayPal',
        description: "<a href=\"https://paypal.me/danielvsampaio\">https://paypal.me/danielvsampaio</a>",
        image: 'payment_options/paypal.webp'
      }
    ]
  end

end


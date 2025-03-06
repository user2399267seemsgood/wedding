class GiftMailer < ApplicationMailer
  default from: ENV['CONTACT_EMAIL']

  def gift_claimed_email
    @gift = params[:gift]
    mail(to: ENV['CONTACT_EMAIL'], subject: "Gift Claimed: #{@gift.name}")
  end
end


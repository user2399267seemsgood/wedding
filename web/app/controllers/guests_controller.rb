# frozen_string_literal: true

class GuestsController < ApplicationController
  def new
    respond_to :html

    @guest = Guest.new
  end

  def create
    respond_to :html

    # Only allow guests that are in the database.
    existing_guest = Guest.find_by(first_name: guest_params[:first_name], last_name: guest_params[:last_name])
    # Check if there is a plus one with that name
    if !existing_guest
      guest_ids = PlusOne.select(:guest_id).where(first_name: guest_params[:first_name], last_name: guest_params[:last_name])
      # If there is not exactly one match we cannot determine which guest to use.
      if guest_ids.length() == 1
        existing_guest = Guest.find_by(id: guest_ids[0].guest_id)
      end
    end
    # if there is still no match, render not found
    if !existing_guest
      render :not_found
      return
    end
    @guest = existing_guest

    # The guest filled out the form previously.
    if @guest.confirmed_at
      GuestMailer.welcome_back_email(@guest).deliver_now
      render :new_exists
    else
      redirect_to guest_path(@guest)
    end
  end

  def show
    respond_to :html

    @guest = Guest.find_by_id_token(params[:id])
  end

  def update
    @guest = Guest.find_by_id_token(params[:id])

    if @guest.update(guest_params)
      if @guest.attending? && @guest.is_plus_ones_allowed
        redirect_to guest_plus_ones_path(@guest)
      else
        redirect_to confirm_guest_path(@guest)
      end
    else
      render :show
    end
  end

  def confirm
    respond_to :html

    @guest = Guest.find_by_id_token(params[:id])
  end

  def complete
    respond_to :html

    @guest = Guest.find_by_id_token(params[:id])
    Guest.transaction do
      @guest.update!(guest_params)
      @guest.touch :confirmed_at
    end
    GuestMailer.confirmation_email(@guest).deliver_now
  end

  private

  def guest_params
    params.require(:guest).permit(
      :email, :first_name, :last_name, :attending, :diet, :songs, :notes
    )
  end
end

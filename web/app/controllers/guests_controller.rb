# frozen_string_literal: true

class GuestsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:confirm]
 
  def new
    respond_to :html

    @guest = Guest.new
  end

  # Search guests and their plus ones
  def search
    query = params[:name].downcase

    guests = Guest.where("LOWER(first_name) LIKE ?", "%#{query}%").select(:id, :first_name, :last_name)

    plus_one_matches = PlusOne.joins(:guest)
                              .where("LOWER(plus_ones.first_name) LIKE ?", "%#{query}%")
                              .pluck("plus_ones.id", "plus_ones.first_name", "plus_ones.last_name", "guests.id")
                              .map { |plus_one_id, plus_one_first_name, plus_one_last_name, guest_id| { id: guest_id, first_name: plus_one_first_name, last_name: plus_one_last_name } }

    matches = guests + plus_one_matches
    render json: { guests: matches.uniq }
  end

  def create
    respond_to :html

    # Only allow guests that are in the database.
    existing_guest = Guest.find_by(id: guest_params[:guest_id])
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
      :guest_id, :email, :first_name, :last_name, :attending, :diet, :songs, :notes
    )
  end
end

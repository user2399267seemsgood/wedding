# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @google_maps_url = 'https://maps.app.goo.gl/iao2eALm4x3pLKgx5'
  end

  def switch_locale
    cookies[:locale] = params[:locale].to_sym
    redirect_to request.referrer || root_path
  end
end

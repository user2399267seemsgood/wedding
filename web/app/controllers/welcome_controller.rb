# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @google_maps_url = 'https://maps.app.goo.gl/CNJj3cWefU9G3WzS6'
    @cool_earth_url = 'https://www.coolearth.org/'
  end

  def switch_locale
    cookies[:locale] = params[:locale].to_sym
    redirect_to request.referrer || root_path
  end
end

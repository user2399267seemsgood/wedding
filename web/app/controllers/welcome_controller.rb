# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @google_maps_url = 'https://maps.app.goo.gl/wNyS1za5spREvUT4A'
    @google_maps_url_dinner = 'https://maps.app.goo.gl/d6rh3m4TiEZvfFgu5'
    @google_maps_url_hotel = 'https://maps.app.goo.gl/JNDD6v5TGikUwQaY9'
  end

  def switch_locale
    cookies[:locale] = params[:locale].to_sym
    redirect_to request.referrer || root_path
  end
end

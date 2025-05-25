# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  if ENV['BASIC_AUTH_NAME'] && ENV['BASIC_AUTH_PASSWORD']
    http_basic_authenticate_with \
      name: ENV['BASIC_AUTH_NAME'],
      password: ENV['BASIC_AUTH_PASSWORD']
  end

  private

  def set_locale
    I18n.locale = cookies[:locale] || :pt
  end
end

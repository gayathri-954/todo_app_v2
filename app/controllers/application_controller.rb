class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  # Disable CSRF only for JSON requests (API testing)
  protect_from_forgery unless: -> { request.format.json? }

  # Require auth for your own controllers only, not DeviseTokenAuth
  before_action :authenticate_user!, unless: :devise_controller?

  private

  def devise_controller?
    is_a?(DeviseTokenAuth::RegistrationsController) ||
      is_a?(DeviseTokenAuth::SessionsController)
  end
end

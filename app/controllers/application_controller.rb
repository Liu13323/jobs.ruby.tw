class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :set_locale

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::RoutingError, with: :not_found

  def not_found
    render text: 'Not found'
  end

  protected

  def set_locale
    if params[:locale] && %w(en zh_tw).include?(params[:locale])
      session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end

  def render_not_found
    render template: 'pages/404', status: 404
  end
end

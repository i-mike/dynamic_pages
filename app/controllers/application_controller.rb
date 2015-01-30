class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :set_current_and_default_languages

  def default_url_options(options={})
    # { locale_or_role: request.params[:locale_or_role] }
    # { locale: 'en' }
    # if Rails.env.development?
    #   {:host => 'mike.asdcode.com'}
    # end

    { locale: I18n.locale }.merge options
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:nickname,
                                                            :password,
                                                            :password_confirmation,
                                                            :remember_me) }

    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:nickname,
                                                            :password,
                                                            :remember_me) }

    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:nickname,
                                                                   :password,
                                                                   :password_confirmation,
                                                                   :current_password) }
  end

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  # def set_current_and_default_languages
  #   @current_language ||= Language.find_by(slug: params[:locale])
  #   @default_language ||= Language.find_by(slug: 'en')
  # end

end

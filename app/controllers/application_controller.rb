class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |e|
    redirect_to root_url, alert: e.message
  end

  protected

  def configure_devise_permitted_parameters
    registration_params = [:name, :email, :password, :password_confirmation, :provider, :uid]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) {
          |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) {
          |u| u.permit(registration_params)
      }
    end

    def not_found(resource_name = nil, exception = nil)
      logger.error(exception.inspect) if exception
      if resource_name
        flash.now[:alert] = I18n.t('flash.missing')
      else
        flash.now[:alert] = I18n.t('flash.generic')
      end
      render 'errors/admin_404', status: :not_found
    end
  end

end

class Api::ApiController < ApplicationController
  protect_from_forgery with: :null_session
  #before_filter :login_http_api_user
  skip_before_filter :authenticate_user!
  before_filter :setup_pagination

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render_json_error exception.message, :not_found
  end

  rescue_from ActionController::ParameterMissing, Workflow::NoTransitionAllowed do |exception|
    render_json_error exception.message, :bad_request
  end

  rescue_from RuntimeError, NameError, ArgumentError do |exception|
    render_json_error "An internal server error occurred", :internal_server_error
  end

protected

  def login_http_api_user
    authenticate_or_request_with_http_basic do |email, token|
      user = User.find_by_api_credentials(email, token)
      user ? sign_in(user) : false
    end
  end

  def setup_pagination
    Kaminari.configure do |c|
      c.default_per_page = 20
      c.max_per_page = 20
    end
  end

  def render_json_error(msg, status)
    if $!
      logger.error("Exception: #{$!.inspect}")
      logger.error($!.backtrace.join("\n  "))
    end
    render json: {request_id: request.uuid, error: msg}, status: status
  end
end

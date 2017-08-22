class ApplicationController < ActionController::API
  include Pundit
  include Knock::Authenticable
  before_action :authenticate_user
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :params_missing

  private

  def user_not_authorized(exception)
    error!(
      'You are not authorized to perform this action',
      :unauthorized,
      exception
    )
  end

  def record_not_found(exception)
    error!(
      'Record not found with given id',
      :not_found,
      exception
    )
  end

  def unauthorized_entity(entity)
    error!(
      'Token is missing in the header request or it is invalid!',
      :unauthorized,
      nil
    )
  end

  def params_missing(exception)
    error!(
      exception,
      :unprocessable_entity,
      exception
    )
  end

  def error!(message, status, exception=nil)
    backtrace = exception && exception.backtrace

    if Rails.env.production?
      render json: {
        errors: message
      }, status: status
    else
      render json: {
        errors: message,
        exception: exception,
        backtrace: backtrace,
      }, status: status
    end
  end
end

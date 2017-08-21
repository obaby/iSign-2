class ApplicationController < ActionController::API
  include Knock::Authenticable
  include Pundit
  before_action :authenticate_user
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    render json: { errors: 'You are not authorized to perform this action!' }
  end
end

class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  # GET /current_user
  def show
    render json: current_user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :first_name,
      :last_name,
      :phone_number
    )
  end
end

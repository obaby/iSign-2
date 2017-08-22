class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  # GET /users/1
  def show
    @user = User.find(params[:id])
    authorize @user, :show?
    render json: { data: current_user }
  end

  # POST /users
  def create
    @user = User.new(user_params)
    authorize @user, :create?

    if @user.save
      render json: { data: @user }
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

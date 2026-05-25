class UsersController < ApplicationController
  before_action :authenticate_user!  # Devise method to ensure user is logged in

  # GET /users/me
  def me
    render json: current_user, status: :ok
  end

  # PATCH/PUT /users/me
  def update
    if current_user.update(user_params)
      render json: current_user, status: :ok
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # Only allow permitted attributes
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

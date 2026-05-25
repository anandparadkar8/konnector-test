# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  before_action :authenticate_user!

  private

  # Authenticate the user via JWT
  def authenticate_user!
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    if token
      decoded = JsonWebToken.decode(token)
      if decoded
        @current_user = User.find_by(id: decoded[:user_id])
      end
    end

    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  end

  def current_user
    @current_user
  end

  # Role-based authorization
  def authorize_admin!
    render json: { error: 'Forbidden' }, status: :forbidden unless current_user&.admin?
  end

  def authorize_school_admin!
    render json: { error: 'Forbidden' }, status: :forbidden unless current_user&.school_admin?
  end

  def authorize_student!
    render json: { error: 'Forbidden' }, status: :forbidden unless current_user&.student?
  end
end

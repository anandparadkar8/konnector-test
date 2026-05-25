# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    super  # Call Devise's default create method
  end

  private

  # Called after successful login
  def respond_with(resource, _opts = {})
    token = JsonWebToken.encode(user_id: resource.id)  # Generate the token
    render json: { token: token, user: resource }, status: :ok  # Return token and user data
  end

  # Called after logout
  def respond_to_on_destroy
    render json: { message: 'Logged out successfully' }, status: :ok
  end
end

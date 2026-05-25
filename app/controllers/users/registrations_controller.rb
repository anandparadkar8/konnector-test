# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # Override the create method

  def create
    binding.pry
    build_resource(sign_up_params)
  resource.name = params[:user][:name]  # Adding a custom field

  if resource.save
    token = JsonWebToken.encode(user_id: resource.id)
    render json: { token: token, user: resource }, status: :created
  else
    render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
  end
  end

  private

  # This method is called after user registration.
  def respond_with(resource, _opts = {})
    if resource.persisted?
      # Create JWT token after successful registration
      token = JsonWebToken.encode(user_id: resource.id)

      # Respond with user data and token in JSON format
      render json: { token: token, user: resource }, status: :created
    else
      # Respond with error if user is not created
      render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # You can also override the destroy method if you want to customize user deletion (if needed).
  def respond_to_on_destroy
    render json: { message: 'User deleted successfully' }, status: :ok
  end
end

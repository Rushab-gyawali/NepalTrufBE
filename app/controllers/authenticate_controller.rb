class AuthenticateController < ApplicationController
  # ❌ Do not require authentication for login/register
  skip_before_action :authenticate_user!, only: [:login, :register]

  # POST /login
  def login
    user = User.find_by(email: auth_params[:email])
    if user&.valid_password?(auth_params[:password])
      token = JsonWebToken.encode(user_id: user.id)

      response.set_header('Authorization', "Bearer #{token}")
      render json: {
        token: token,
        user: { id: user.id, email: user.email, role: user.role }
      }, status: :ok
    else
      render json: { errors: ['Invalid email or password'] }, status: :unauthorized
    end
  end

  # POST /register
  def register
    user = User.new(register_params)
    if user.save
      render json: { user: { id: user.id, email: user.email, role: user.role } }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def auth_params
    params.require(:user).permit(:email, :password)
  end

  def register_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end
end

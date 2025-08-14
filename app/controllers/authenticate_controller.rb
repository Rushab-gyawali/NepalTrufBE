class AuthenticateController < ApplicationController
  before_action :authenticate_user!, only: [:register]

  # POST /login
  def login
    user = User.find_for_database_authentication(email: auth_params[:email])
    if user&.valid_password?(auth_params[:password])
      token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
      response.set_header('x-api-key', token)

      render json: { user: { id: user.id, email: user.email, role: user.role } }, status: :ok
    else
      render json: { errors: ['Invalid Email/Password'] }, status: :unauthorized
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

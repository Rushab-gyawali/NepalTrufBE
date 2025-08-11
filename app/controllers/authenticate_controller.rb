class AuthenticateController < ApplicationController
  before_action :authenticate_user!, only: [ :register]
  #post 'login'
  def login
    user = User.find_for_database_authentication(email: auth_params[:email])
    if user&.valid_password?(auth_params[:password])
      render json: payload(user)
    else
      render json: { errors: ['Invalid Username/Password'] }, status: :unauthorized
    end
  end

  def register
  end

  private
  def auth_params
    params.require(:user).permit(:email, :password)
  end

  def payload(user)
    return nil unless user and user.id
    {
      auth_token: JsonWebToken.encode({user_id: user.id}),
      user: {id: user.id, email: user.email}
    }
  end
end
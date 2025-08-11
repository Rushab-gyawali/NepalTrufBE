class AuthenticateController < ApplicationController

  #get 'login'
  def login
    @user = User.find_by(email: auth_params[:email])
    
    if @user && @user.authenticate(auth_params[:password])
      render json: { message: 'Login successful', user: @user }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def register
  end

  private
  def auth_params
    params.expect(user: [ :email, :password ])
  end

end

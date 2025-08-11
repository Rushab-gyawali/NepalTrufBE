class ApplicationController < ActionController::Base
# before_action: authenticate_user!

  def current_user
    @current_user ||= User.find(JsonWebToken.decode(request.headers['Authorization'])[:user_id]) if request.headers['Authorization'].present?
  rescue
    nil
  end

  def authenticate_user!
    render json: { error: 'Not authorized' }, status: :unauthorized unless current_user
  end
end
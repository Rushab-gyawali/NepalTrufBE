class ApplicationController < ActionController::Base
# before_action  :authenticate_user!
attr_reader :jwt_payload

  def current_user
    return @current_user if defined?(@current_user)

    auth_header = request.headers['Authorization']
    token = auth_header&.split(' ')&.last
    return @current_user = nil unless token
    decoded = JsonWebToken.decode(token)
    return @current_user = nil unless decoded && decoded[:user_id]

    @current_user = User.find_by(id: decoded[:user_id])
  rescue JWT::DecodeError, JWT::ExpiredSignature
    @current_user = nil
  end 

  def authenticate_user!
    head :unauthorized unless current_user
  end

  def authorize_role!(*roles)
    head :forbidden unless current_user && roles.map(&:to_s).include?(current_user.role)
  end
end
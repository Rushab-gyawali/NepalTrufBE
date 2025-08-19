class ApplicationController < ActionController::API
  # include::Authorization
  before_action :authenticate_user!
  attr_reader :current_user, :jwt_payload

  private

  def authenticate_user!
    auth_header = request.headers['Authorization']
    token = auth_header&.split(' ')&.last

    return head(:unauthorized) unless token

    begin
      decoded = JsonWebToken.decode(token)
      return head(:unauthorized) unless decoded && decoded[:user_id]

      @jwt_payload = decoded
      @current_user = User.find_by(id: decoded[:user_id])
      return head(:unauthorized) unless @current_user

    rescue JWT::DecodeError, JWT::ExpiredSignature => e
      return head(:unauthorized)
    end
  end
end

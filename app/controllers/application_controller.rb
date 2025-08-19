class ApplicationController < ActionController::API
  before_action :authenticate_user!
  attr_reader :current_user, :jwt_payload

  private

  def authenticate_user!
    Rails.logger.info("Authorization header: #{request.headers['Authorization'].inspect}")

    auth_header = request.headers['Authorization']
    token = auth_header&.split(' ')&.last
    Rails.logger.info("Extracted token: #{token.inspect}")

    return head(:unauthorized) unless token

    begin
      decoded = JsonWebToken.decode(token)
      Rails.logger.info("Decoded JWT payload: #{decoded.inspect}")

      return head(:unauthorized) unless decoded && decoded[:user_id]

      @jwt_payload = decoded
      @current_user = User.find_by(id: decoded[:user_id])
      Rails.logger.info("Current user found: #{@current_user.inspect}")

      return head(:unauthorized) unless @current_user

    rescue JWT::DecodeError, JWT::ExpiredSignature => e
      Rails.logger.warn("JWT Error: #{e.message}")
      return head(:unauthorized)
    end
  end
end

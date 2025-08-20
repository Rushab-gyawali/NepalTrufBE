class ApplicationController < ActionController::API
  include Pundit::Authorization

  set_current_tenant_through_filter
  before_action :authenticate_user!
  before_action :set_tenant
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  attr_reader :current_user

  private

  def authenticate_user!
    auth_header = request.headers['Authorization']
    token = auth_header&.split(' ')&.last
    return head(:unauthorized) unless token

    begin
      decoded = JsonWebToken.decode(token)
      return head(:unauthorized) unless decoded && decoded[:user_id]
      debugger
      @current_user = User.find_by(id: decoded["user_id"])
      return head(:unauthorized) unless @current_user

    rescue JWT::DecodeError, JWT::ExpiredSignature => e
      return head(:unauthorized)
    end
  end

  def user_not_authorized
    render json: { error: "You are not authorized to perform this action." }, status: :forbidden
  end
  
  def set_tenant
    return unless @current_user

    sports_field = SportsField.find_by(owner_id: @current_user.id)
    set_current_tenant(sports_field) if sports_field.present?
  end
end

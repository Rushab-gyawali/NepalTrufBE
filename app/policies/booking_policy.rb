class BookingPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.is_admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def index?
    user.is_admin? || user.is_user?
  end

end

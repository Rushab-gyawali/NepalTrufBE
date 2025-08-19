class BookingPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.is_admin?
        scope.all
      elsif user.is_test?
        scope.none
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def index?
    user.is_admin? || user.is_user? 
  end

end

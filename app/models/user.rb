class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
  belongs_to :organization
  has_many :sports_fields, dependent: :destroy
  has_many :bookings, dependent: :destroy

  def is_admin?
    role == 'admin'
  end

  def is_user?
    role == 'user'
  end

  def is_staff?
    role == "staff"
  end

  def can_view_booking?
    is_admin? || is_staff?
  end
  
end

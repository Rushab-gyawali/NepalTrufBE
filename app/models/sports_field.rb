class SportsField < ApplicationRecord
    belongs_to :user, foreign_key: :owner_id
    validates :owner_id, presence: true, uniqueness: true
    has_many :bookings
end

class SportsField < ApplicationRecord
    belongs_to :organization
    has_many :bookings, dependent: :destroy
end

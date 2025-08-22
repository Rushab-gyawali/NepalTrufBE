class Organization < ApplicationRecord
    has_many :sports_fields, dependent: :destroy
    has_many :users, dependent: :destroy
    has_many :bookings, dependent: :destroy
end

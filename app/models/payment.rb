class Payment < ApplicationRecord
    belongs_to :booking, foreign_key: :booking_id
end

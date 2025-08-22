class Booking < ApplicationRecord
    acts_as_tenant :sports_field
    belongs_to :user
    belongs_to :sports_field
    belongs_to :organization

    before_save :is_field_available
    before_save :calculate_total_price

    def calculate_total_price
        if start_time && end_time && sports_field
            total_hours = ((end_time - start_time) / 1.hour).ceil
            self.total_price = total_hours * sports_field.hourly_rate
        else
            self.total_price = 0
        end
    end

    def is_field_available
        if start_time && end_time && sports_field
          booked_times = Booking.where(sports_field_id: sports_field.id)
                                .where("start_time < ? AND end_time > ?", end_time, start_time)
      
          if booked_times.exists?      
            time_slots = booked_times.map do |booking|
              "#{booking.start_time.strftime("%Y-%m-%d %H:%M")} to #{booking.end_time.strftime("%Y-%m-%d %H:%M")}"
            end.join(", ")
      
            errors.add(:base, 
                       "The sports field is already booked during: #{time_slots}. Please choose a different time slot.")
            throw :abort
        end
        else
          errors.add(:base, "Start time, end time, and sports field must be present.")
          throw :abort
        end
    end
end

class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show update destroy ]

  # GET /bookings
  def index
    @bookings = policy_scope(Booking.includes(:user, :sports_field))
    authorize Booking
    
    render json: @bookings.map { |booking|
    {
      id: booking.id,
      start_time: booking.start_time,
      end_time: booking.end_time,
      status: booking.status,
      total_price: booking.total_price,
      payment_status: booking.payment_status,
      user_name: booking.user&.name,
      sports_field_name: booking.sports_field&.name
    }
  }
  end

  # GET /bookings/1
  def show
    render json: @booking
  end

  # POST /bookings
  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      render json: @booking, status: :created, location: @booking
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bookings/1
  def update
    if @booking.update(booking_params)
      render json: @booking
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bookings/1
  def destroy
    @booking.destroy!
  end

  private
     def set_booking
      @booking = Booking.find(params[:id]) 
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.expect(booking: [ :user_id, :sports_field_id, :start_time, :end_time, :status, :payment_status ])
    end

end

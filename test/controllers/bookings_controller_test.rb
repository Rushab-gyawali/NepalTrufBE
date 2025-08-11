require "test_helper"

class BookingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @booking = bookings(:one)
  end

  test "should get index" do
    get bookings_url, as: :json
    assert_response :success
  end

  test "should create booking" do
    assert_difference("Booking.count") do
      post bookings_url, params: { booking: { end_time: @booking.end_time, payment_status: @booking.payment_status, sports_field_id: @booking.sports_field_id, start_time: @booking.start_time, status: @booking.status, total_price: @booking.total_price, user_id: @booking.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show booking" do
    get booking_url(@booking), as: :json
    assert_response :success
  end

  test "should update booking" do
    patch booking_url(@booking), params: { booking: { end_time: @booking.end_time, payment_status: @booking.payment_status, sports_field_id: @booking.sports_field_id, start_time: @booking.start_time, status: @booking.status, total_price: @booking.total_price, user_id: @booking.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy booking" do
    assert_difference("Booking.count", -1) do
      delete booking_url(@booking), as: :json
    end

    assert_response :no_content
  end
end

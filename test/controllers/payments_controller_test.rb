require "test_helper"

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payment = payments(:one)
  end

  test "should get index" do
    get payments_url, as: :json
    assert_response :success
  end

  test "should create payment" do
    assert_difference("Payment.count") do
      post payments_url, params: { payment: { amount: @payment.amount, booking_id: @payment.booking_id, datetime: @payment.datetime, decimal: @payment.decimal, method: @payment.method, paid_at: @payment.paid_at, status: @payment.status, transaction_id: @payment.transaction_id } }, as: :json
    end

    assert_response :created
  end

  test "should show payment" do
    get payment_url(@payment), as: :json
    assert_response :success
  end

  test "should update payment" do
    patch payment_url(@payment), params: { payment: { amount: @payment.amount, booking_id: @payment.booking_id, datetime: @payment.datetime, decimal: @payment.decimal, method: @payment.method, paid_at: @payment.paid_at, status: @payment.status, transaction_id: @payment.transaction_id } }, as: :json
    assert_response :success
  end

  test "should destroy payment" do
    assert_difference("Payment.count", -1) do
      delete payment_url(@payment), as: :json
    end

    assert_response :no_content
  end
end

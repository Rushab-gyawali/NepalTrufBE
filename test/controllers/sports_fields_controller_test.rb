require "test_helper"

class SportsFieldsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sports_field = sports_fields(:one)
  end

  test "should get index" do
    get sports_fields_url, as: :json
    assert_response :success
  end

  test "should create sports_field" do
    assert_difference("SportsField.count") do
      post sports_fields_url, params: { sports_field: { address: @sports_field.address, description: @sports_field.description, field_type: @sports_field.field_type, hourly_rate: @sports_field.hourly_rate, image_url: @sports_field.image_url, is_active: @sports_field.is_active, latitude: @sports_field.latitude, longitude: @sports_field.longitude, name: @sports_field.name, owner_id: @sports_field.owner_id } }, as: :json
    end

    assert_response :created
  end

  test "should show sports_field" do
    get sports_field_url(@sports_field), as: :json
    assert_response :success
  end

  test "should update sports_field" do
    patch sports_field_url(@sports_field), params: { sports_field: { address: @sports_field.address, description: @sports_field.description, field_type: @sports_field.field_type, hourly_rate: @sports_field.hourly_rate, image_url: @sports_field.image_url, is_active: @sports_field.is_active, latitude: @sports_field.latitude, longitude: @sports_field.longitude, name: @sports_field.name, owner_id: @sports_field.owner_id } }, as: :json
    assert_response :success
  end

  test "should destroy sports_field" do
    assert_difference("SportsField.count", -1) do
      delete sports_field_url(@sports_field), as: :json
    end

    assert_response :no_content
  end
end

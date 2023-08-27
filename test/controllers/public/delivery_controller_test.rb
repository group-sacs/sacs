require "test_helper"

class Public::DeliveryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_delivery_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_delivery_edit_url
    assert_response :success
  end
end

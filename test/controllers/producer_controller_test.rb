require 'test_helper'

class ProducerControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get producer_new_url
    assert_response :success
  end

end

require 'test_helper'

class TokenControllerTest < ActionController::TestCase
  test "should get value" do
    get :value
    assert_response :success
  end

end

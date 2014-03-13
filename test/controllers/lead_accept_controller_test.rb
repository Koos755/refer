require 'test_helper'

class LeadAcceptControllerTest < ActionController::TestCase
  test "should get agent" do
    get :agent
    assert_response :success
  end

  test "should get broker" do
    get :broker
    assert_response :success
  end

  test "should get agent_reply" do
    get :agent_reply
    assert_response :success
  end

  test "should get broker_apply" do
    get :broker_apply
    assert_response :success
  end

end

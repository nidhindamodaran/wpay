require 'test_helper'

class TokensControllerTest < ActionDispatch::IntegrationTest
  test "should get authenticate" do
    get tokens_authenticate_url
    assert_response :success
  end

end

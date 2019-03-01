require 'test_helper'

class ScratchCardsControllerTest < ActionDispatch::IntegrationTest
  test "should get scratch" do
    get scratch_cards_scratch_url
    assert_response :success
  end

end

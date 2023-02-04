require "test_helper"

class Public::TagRelationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_tag_relations_index_url
    assert_response :success
  end
end

require "test_helper"

class HeadToHeadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @head_to_head = head_to_heads(:one)
  end

  test "should get index" do
    get head_to_heads_url
    assert_response :success
  end

  test "should get new" do
    get new_head_to_head_url
    assert_response :success
  end

  test "should create head_to_head" do
    assert_difference("HeadToHead.count") do
      post head_to_heads_url, params: { head_to_head: {  } }
    end

    assert_redirected_to head_to_head_url(HeadToHead.last)
  end

  test "should show head_to_head" do
    get head_to_head_url(@head_to_head)
    assert_response :success
  end

  test "should get edit" do
    get edit_head_to_head_url(@head_to_head)
    assert_response :success
  end

  test "should update head_to_head" do
    patch head_to_head_url(@head_to_head), params: { head_to_head: {  } }
    assert_redirected_to head_to_head_url(@head_to_head)
  end

  test "should destroy head_to_head" do
    assert_difference("HeadToHead.count", -1) do
      delete head_to_head_url(@head_to_head)
    end

    assert_redirected_to head_to_heads_url
  end
end

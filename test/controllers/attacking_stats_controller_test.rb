require "test_helper"

class AttackingStatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @attacking_stat = attacking_stats(:one)
  end

  test "should get index" do
    get attacking_stats_url
    assert_response :success
  end

  test "should get new" do
    get new_attacking_stat_url
    assert_response :success
  end

  test "should create attacking_stat" do
    assert_difference("AttackingStat.count") do
      post attacking_stats_url, params: { attacking_stat: {  } }
    end

    assert_redirected_to attacking_stat_url(AttackingStat.last)
  end

  test "should show attacking_stat" do
    get attacking_stat_url(@attacking_stat)
    assert_response :success
  end

  test "should get edit" do
    get edit_attacking_stat_url(@attacking_stat)
    assert_response :success
  end

  test "should update attacking_stat" do
    patch attacking_stat_url(@attacking_stat), params: { attacking_stat: {  } }
    assert_redirected_to attacking_stat_url(@attacking_stat)
  end

  test "should destroy attacking_stat" do
    assert_difference("AttackingStat.count", -1) do
      delete attacking_stat_url(@attacking_stat)
    end

    assert_redirected_to attacking_stats_url
  end
end

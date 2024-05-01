require "test_helper"

class DefensiveStatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @defensive_stat = defensive_stats(:one)
  end

  test "should get index" do
    get defensive_stats_url
    assert_response :success
  end

  test "should get new" do
    get new_defensive_stat_url
    assert_response :success
  end

  test "should create defensive_stat" do
    assert_difference("DefensiveStat.count") do
      post defensive_stats_url, params: { defensive_stat: {  } }
    end

    assert_redirected_to defensive_stat_url(DefensiveStat.last)
  end

  test "should show defensive_stat" do
    get defensive_stat_url(@defensive_stat)
    assert_response :success
  end

  test "should get edit" do
    get edit_defensive_stat_url(@defensive_stat)
    assert_response :success
  end

  test "should update defensive_stat" do
    patch defensive_stat_url(@defensive_stat), params: { defensive_stat: {  } }
    assert_redirected_to defensive_stat_url(@defensive_stat)
  end

  test "should destroy defensive_stat" do
    assert_difference("DefensiveStat.count", -1) do
      delete defensive_stat_url(@defensive_stat)
    end

    assert_redirected_to defensive_stats_url
  end
end

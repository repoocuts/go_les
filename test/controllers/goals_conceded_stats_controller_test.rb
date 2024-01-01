require "test_helper"

class GoalsConcededStatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @goals_conceded_stat = goals_conceded_stats(:one)
  end

  test "should get index" do
    get goals_conceded_stats_url
    assert_response :success
  end

  test "should get new" do
    get new_goals_conceded_stat_url
    assert_response :success
  end

  test "should create goals_conceded_stat" do
    assert_difference("GoalsConcededStat.count") do
      post goals_conceded_stats_url, params: { goals_conceded_stat: {  } }
    end

    assert_redirected_to goals_conceded_stat_url(GoalsConcededStat.last)
  end

  test "should show goals_conceded_stat" do
    get goals_conceded_stat_url(@goals_conceded_stat)
    assert_response :success
  end

  test "should get edit" do
    get edit_goals_conceded_stat_url(@goals_conceded_stat)
    assert_response :success
  end

  test "should update goals_conceded_stat" do
    patch goals_conceded_stat_url(@goals_conceded_stat), params: { goals_conceded_stat: {  } }
    assert_redirected_to goals_conceded_stat_url(@goals_conceded_stat)
  end

  test "should destroy goals_conceded_stat" do
    assert_difference("GoalsConcededStat.count", -1) do
      delete goals_conceded_stat_url(@goals_conceded_stat)
    end

    assert_redirected_to goals_conceded_stats_url
  end
end

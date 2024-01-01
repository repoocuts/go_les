require "test_helper"

class GoalsScoredStatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @goals_scored_stat = goals_scored_stats(:one)
  end

  test "should get index" do
    get goals_scored_stats_url
    assert_response :success
  end

  test "should get new" do
    get new_goals_scored_stat_url
    assert_response :success
  end

  test "should create goals_scored_stat" do
    assert_difference("GoalsScoredStat.count") do
      post goals_scored_stats_url, params: { goals_scored_stat: {  } }
    end

    assert_redirected_to goals_scored_stat_url(GoalsScoredStat.last)
  end

  test "should show goals_scored_stat" do
    get goals_scored_stat_url(@goals_scored_stat)
    assert_response :success
  end

  test "should get edit" do
    get edit_goals_scored_stat_url(@goals_scored_stat)
    assert_response :success
  end

  test "should update goals_scored_stat" do
    patch goals_scored_stat_url(@goals_scored_stat), params: { goals_scored_stat: {  } }
    assert_redirected_to goals_scored_stat_url(@goals_scored_stat)
  end

  test "should destroy goals_scored_stat" do
    assert_difference("GoalsScoredStat.count", -1) do
      delete goals_scored_stat_url(@goals_scored_stat)
    end

    assert_redirected_to goals_scored_stats_url
  end
end

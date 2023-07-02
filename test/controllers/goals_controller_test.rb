require "test_helper"

class GoalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @goal = goals(:one)
  end

  test "should get index" do
    get goals_url
    assert_response :success
  end

  test "should get new" do
    get new_goal_url
    assert_response :success
  end

  test "should create goal" do
    assert_difference("Goal.count") do
      post goals_url, params: { goal: { fixture_id: @goal.fixture_id, goal_type: @goal.goal_type, is_home: @goal.is_home, minute: @goal.minute, own_goal: @goal.own_goal, player_season_id: @goal.player_season_id, team_season_id: @goal.team_season_id } }
    end

    assert_redirected_to goal_url(Goal.last)
  end

  test "should show goal" do
    get goal_url(@goal)
    assert_response :success
  end

  test "should get edit" do
    get edit_goal_url(@goal)
    assert_response :success
  end

  test "should update goal" do
    patch goal_url(@goal), params: { goal: { fixture_id: @goal.fixture_id, goal_type: @goal.goal_type, is_home: @goal.is_home, minute: @goal.minute, own_goal: @goal.own_goal, player_season_id: @goal.player_season_id, team_season_id: @goal.team_season_id } }
    assert_redirected_to goal_url(@goal)
  end

  test "should destroy goal" do
    assert_difference("Goal.count", -1) do
      delete goal_url(@goal)
    end

    assert_redirected_to goals_url
  end
end

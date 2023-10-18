require "test_helper"

class AssistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @assist = assists(:one)
  end

  test "should get index" do
    get assists_url
    assert_response :success
  end

  test "should get new" do
    get new_assist_url
    assert_response :success
  end

  test "should create assist" do
    assert_difference("Assist.count") do
      post assists_url, params: { assist: { appearances_id: @assist.appearances_id, fixture_id: @assist.fixture_id, goal_id: @assist.goal_id, is_home: @assist.is_home, minute: @assist.minute, player_season_id: @assist.player_season_id, team_season_id: @assist.team_season_id } }
    end

    assert_redirected_to assist_url(Assist.last)
  end

  test "should show assist" do
    get assist_url(@assist)
    assert_response :success
  end

  test "should get edit" do
    get edit_assist_url(@assist)
    assert_response :success
  end

  test "should update assist" do
    patch assist_url(@assist), params: { assist: { appearances_id: @assist.appearances_id, fixture_id: @assist.fixture_id, goal_id: @assist.goal_id, is_home: @assist.is_home, minute: @assist.minute, player_season_id: @assist.player_season_id, team_season_id: @assist.team_season_id } }
    assert_redirected_to assist_url(@assist)
  end

  test "should destroy assist" do
    assert_difference("Assist.count", -1) do
      delete assist_url(@assist)
    end

    assert_redirected_to assists_url
  end
end

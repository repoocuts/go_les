require "test_helper"

class TeamSeasonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @team_season = team_seasons(:one)
  end

  test "should get index" do
    get team_seasons_url
    assert_response :success
  end

  test "should get new" do
    get new_team_season_url
    assert_response :success
  end

  test "should create team_season" do
    assert_difference("TeamSeason.count") do
      post team_seasons_url, params: { team_season: { api_football_id: @team_season.api_football_id, season_id: @team_season.season_id, team_id: @team_season.team_id } }
    end

    assert_redirected_to team_season_url(TeamSeason.last)
  end

  test "should show team_season" do
    get team_season_url(@team_season)
    assert_response :success
  end

  test "should get edit" do
    get edit_team_season_url(@team_season)
    assert_response :success
  end

  test "should update team_season" do
    patch team_season_url(@team_season), params: { team_season: { api_football_id: @team_season.api_football_id, season_id: @team_season.season_id, team_id: @team_season.team_id } }
    assert_redirected_to team_season_url(@team_season)
  end

  test "should destroy team_season" do
    assert_difference("TeamSeason.count", -1) do
      delete team_season_url(@team_season)
    end

    assert_redirected_to team_seasons_url
  end
end

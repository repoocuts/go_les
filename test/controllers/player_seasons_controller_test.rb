require "test_helper"

class PlayerSeasonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player_season = player_seasons(:one)
  end

  test "should get index" do
    get player_seasons_url
    assert_response :success
  end

  test "should get new" do
    get new_player_season_url
    assert_response :success
  end

  test "should create player_season" do
    assert_difference("PlayerSeason.count") do
      post player_seasons_url, params: { player_season: { api_football_id: @player_season.api_football_id, player_id: @player_season.player_id, team_season_id: @player_season.team_season_id } }
    end

    assert_redirected_to player_season_url(PlayerSeason.last)
  end

  test "should show player_season" do
    get player_season_url(@player_season)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_season_url(@player_season)
    assert_response :success
  end

  test "should update player_season" do
    patch player_season_url(@player_season), params: { player_season: { api_football_id: @player_season.api_football_id, player_id: @player_season.player_id, team_season_id: @player_season.team_season_id } }
    assert_redirected_to player_season_url(@player_season)
  end

  test "should destroy player_season" do
    assert_difference("PlayerSeason.count", -1) do
      delete player_season_url(@player_season)
    end

    assert_redirected_to player_seasons_url
  end
end

require "test_helper"

class FixturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fixture = fixtures(:one)
  end

  test "should get index" do
    get fixtures_url
    assert_response :success
  end

  test "should get new" do
    get new_fixture_url
    assert_response :success
  end

  test "should create fixture" do
    assert_difference("Fixture.count") do
      post fixtures_url, params: { fixture: { api_football_id: @fixture.api_football_id, away_score: @fixture.away_score, away_team_season_id: @fixture.away_team_season_id, game_week: @fixture.game_week, home_score: @fixture.home_score, home_team_season_id: @fixture.home_team_season_id, kick_off: @fixture.kick_off, league_id: @fixture.league_id, season_id: @fixture.season_id } }
    end

    assert_redirected_to fixture_url(Fixture.last)
  end

  test "should show fixture" do
    get fixture_url(@fixture)
    assert_response :success
  end

  test "should get edit" do
    get edit_fixture_url(@fixture)
    assert_response :success
  end

  test "should update fixture" do
    patch fixture_url(@fixture), params: { fixture: { api_football_id: @fixture.api_football_id, away_score: @fixture.away_score, away_team_season_id: @fixture.away_team_season_id, game_week: @fixture.game_week, home_score: @fixture.home_score, home_team_season_id: @fixture.home_team_season_id, kick_off: @fixture.kick_off, league_id: @fixture.league_id, season_id: @fixture.season_id } }
    assert_redirected_to fixture_url(@fixture)
  end

  test "should destroy fixture" do
    assert_difference("Fixture.count", -1) do
      delete fixture_url(@fixture)
    end

    assert_redirected_to fixtures_url
  end
end

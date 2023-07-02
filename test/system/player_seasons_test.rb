require "application_system_test_case"

class PlayerSeasonsTest < ApplicationSystemTestCase
  setup do
    @player_season = player_seasons(:one)
  end

  test "visiting the index" do
    visit player_seasons_url
    assert_selector "h1", text: "Player seasons"
  end

  test "should create player season" do
    visit player_seasons_url
    click_on "New player season"

    fill_in "Api football", with: @player_season.api_football_id
    fill_in "Player", with: @player_season.player_id
    fill_in "Team season", with: @player_season.team_season_id
    click_on "Create Player season"

    assert_text "Player season was successfully created"
    click_on "Back"
  end

  test "should update Player season" do
    visit player_season_url(@player_season)
    click_on "Edit this player season", match: :first

    fill_in "Api football", with: @player_season.api_football_id
    fill_in "Player", with: @player_season.player_id
    fill_in "Team season", with: @player_season.team_season_id
    click_on "Update Player season"

    assert_text "Player season was successfully updated"
    click_on "Back"
  end

  test "should destroy Player season" do
    visit player_season_url(@player_season)
    click_on "Destroy this player season", match: :first

    assert_text "Player season was successfully destroyed"
  end
end

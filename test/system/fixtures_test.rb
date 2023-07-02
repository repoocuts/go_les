require "application_system_test_case"

class FixturesTest < ApplicationSystemTestCase
  setup do
    @fixture = fixtures(:one)
  end

  test "visiting the index" do
    visit fixtures_url
    assert_selector "h1", text: "Fixtures"
  end

  test "should create fixture" do
    visit fixtures_url
    click_on "New fixture"

    fill_in "Api football", with: @fixture.api_football_id
    fill_in "Away score", with: @fixture.away_score
    fill_in "Away team season", with: @fixture.away_team_season_id
    fill_in "Game week", with: @fixture.game_week
    fill_in "Home score", with: @fixture.home_score
    fill_in "Home team season", with: @fixture.home_team_season_id
    fill_in "Kick off", with: @fixture.kick_off
    fill_in "League", with: @fixture.league_id
    fill_in "Season", with: @fixture.season_id
    click_on "Create Fixture"

    assert_text "Fixture was successfully created"
    click_on "Back"
  end

  test "should update Fixture" do
    visit fixture_url(@fixture)
    click_on "Edit this fixture", match: :first

    fill_in "Api football", with: @fixture.api_football_id
    fill_in "Away score", with: @fixture.away_score
    fill_in "Away team season", with: @fixture.away_team_season_id
    fill_in "Game week", with: @fixture.game_week
    fill_in "Home score", with: @fixture.home_score
    fill_in "Home team season", with: @fixture.home_team_season_id
    fill_in "Kick off", with: @fixture.kick_off
    fill_in "League", with: @fixture.league_id
    fill_in "Season", with: @fixture.season_id
    click_on "Update Fixture"

    assert_text "Fixture was successfully updated"
    click_on "Back"
  end

  test "should destroy Fixture" do
    visit fixture_url(@fixture)
    click_on "Destroy this fixture", match: :first

    assert_text "Fixture was successfully destroyed"
  end
end

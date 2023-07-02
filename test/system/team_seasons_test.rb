require "application_system_test_case"

class TeamSeasonsTest < ApplicationSystemTestCase
  setup do
    @team_season = team_seasons(:one)
  end

  test "visiting the index" do
    visit team_seasons_url
    assert_selector "h1", text: "Team seasons"
  end

  test "should create team season" do
    visit team_seasons_url
    click_on "New team season"

    fill_in "Api football", with: @team_season.api_football_id
    fill_in "Season", with: @team_season.season_id
    fill_in "Team", with: @team_season.team_id
    click_on "Create Team season"

    assert_text "Team season was successfully created"
    click_on "Back"
  end

  test "should update Team season" do
    visit team_season_url(@team_season)
    click_on "Edit this team season", match: :first

    fill_in "Api football", with: @team_season.api_football_id
    fill_in "Season", with: @team_season.season_id
    fill_in "Team", with: @team_season.team_id
    click_on "Update Team season"

    assert_text "Team season was successfully updated"
    click_on "Back"
  end

  test "should destroy Team season" do
    visit team_season_url(@team_season)
    click_on "Destroy this team season", match: :first

    assert_text "Team season was successfully destroyed"
  end
end

require "application_system_test_case"

class AssistsTest < ApplicationSystemTestCase
  setup do
    @assist = assists(:one)
  end

  test "visiting the index" do
    visit assists_url
    assert_selector "h1", text: "Assists"
  end

  test "should create assist" do
    visit assists_url
    click_on "New assist"

    fill_in "Appearances", with: @assist.appearances_id
    fill_in "Fixture", with: @assist.fixture_id
    fill_in "Goal", with: @assist.goal_id
    check "Is home" if @assist.is_home
    fill_in "Minute", with: @assist.minute
    fill_in "Player season", with: @assist.player_season_id
    fill_in "Team season", with: @assist.team_season_id
    click_on "Create Assist"

    assert_text "Assist was successfully created"
    click_on "Back"
  end

  test "should update Assist" do
    visit assist_url(@assist)
    click_on "Edit this assist", match: :first

    fill_in "Appearances", with: @assist.appearances_id
    fill_in "Fixture", with: @assist.fixture_id
    fill_in "Goal", with: @assist.goal_id
    check "Is home" if @assist.is_home
    fill_in "Minute", with: @assist.minute
    fill_in "Player season", with: @assist.player_season_id
    fill_in "Team season", with: @assist.team_season_id
    click_on "Update Assist"

    assert_text "Assist was successfully updated"
    click_on "Back"
  end

  test "should destroy Assist" do
    visit assist_url(@assist)
    click_on "Destroy this assist", match: :first

    assert_text "Assist was successfully destroyed"
  end
end

require "application_system_test_case"

class AppearancesTest < ApplicationSystemTestCase
  setup do
    @appearance = appearances(:one)
  end

  test "visiting the index" do
    visit appearances_url
    assert_selector "h1", text: "Appearances"
  end

  test "should create appearance" do
    visit appearances_url
    click_on "New appearance"

    fill_in "Goal type", with: @appearance.goal_type
    check "Is home" if @appearance.is_home
    fill_in "Minutes", with: @appearance.minutes
    fill_in "Player season", with: @appearance.player_season_id
    click_on "Create Appearance"

    assert_text "Appearance was successfully created"
    click_on "Back"
  end

  test "should update Appearance" do
    visit appearance_url(@appearance)
    click_on "Edit this appearance", match: :first

    fill_in "Goal type", with: @appearance.goal_type
    check "Is home" if @appearance.is_home
    fill_in "Minutes", with: @appearance.minutes
    fill_in "Player season", with: @appearance.player_season_id
    click_on "Update Appearance"

    assert_text "Appearance was successfully updated"
    click_on "Back"
  end

  test "should destroy Appearance" do
    visit appearance_url(@appearance)
    click_on "Destroy this appearance", match: :first

    assert_text "Appearance was successfully destroyed"
  end
end

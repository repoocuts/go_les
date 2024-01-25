require "application_system_test_case"

class RefereeFixturesTest < ApplicationSystemTestCase
  setup do
    @referee_fixture = referee_fixtures(:one)
  end

  test "visiting the index" do
    visit referee_fixtures_url
    assert_selector "h1", text: "Referee fixtures"
  end

  test "should create referee fixture" do
    visit referee_fixtures_url
    click_on "New referee fixture"

    fill_in "Fixture", with: @referee_fixture.fixture_id
    fill_in "Referee", with: @referee_fixture.referee_id
    fill_in "Season", with: @referee_fixture.season_id
    click_on "Create Referee fixture"

    assert_text "Referee fixture was successfully created"
    click_on "Back"
  end

  test "should update Referee fixture" do
    visit referee_fixture_url(@referee_fixture)
    click_on "Edit this referee fixture", match: :first

    fill_in "Fixture", with: @referee_fixture.fixture_id
    fill_in "Referee", with: @referee_fixture.referee_id
    fill_in "Season", with: @referee_fixture.season_id
    click_on "Update Referee fixture"

    assert_text "Referee fixture was successfully updated"
    click_on "Back"
  end

  test "should destroy Referee fixture" do
    visit referee_fixture_url(@referee_fixture)
    click_on "Destroy this referee fixture", match: :first

    assert_text "Referee fixture was successfully destroyed"
  end
end

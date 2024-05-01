require "application_system_test_case"

class DefensiveStatsTest < ApplicationSystemTestCase
  setup do
    @defensive_stat = defensive_stats(:one)
  end

  test "visiting the index" do
    visit defensive_stats_url
    assert_selector "h1", text: "Defensive stats"
  end

  test "should create defensive stat" do
    visit defensive_stats_url
    click_on "New defensive stat"

    click_on "Create Defensive stat"

    assert_text "Defensive stat was successfully created"
    click_on "Back"
  end

  test "should update Defensive stat" do
    visit defensive_stat_url(@defensive_stat)
    click_on "Edit this defensive stat", match: :first

    click_on "Update Defensive stat"

    assert_text "Defensive stat was successfully updated"
    click_on "Back"
  end

  test "should destroy Defensive stat" do
    visit defensive_stat_url(@defensive_stat)
    click_on "Destroy this defensive stat", match: :first

    assert_text "Defensive stat was successfully destroyed"
  end
end

require "application_system_test_case"

class AttackingStatsTest < ApplicationSystemTestCase
  setup do
    @attacking_stat = attacking_stats(:one)
  end

  test "visiting the index" do
    visit attacking_stats_url
    assert_selector "h1", text: "Attacking stats"
  end

  test "should create attacking stat" do
    visit attacking_stats_url
    click_on "New attacking stat"

    click_on "Create Attacking stat"

    assert_text "Attacking stat was successfully created"
    click_on "Back"
  end

  test "should update Attacking stat" do
    visit attacking_stat_url(@attacking_stat)
    click_on "Edit this attacking stat", match: :first

    click_on "Update Attacking stat"

    assert_text "Attacking stat was successfully updated"
    click_on "Back"
  end

  test "should destroy Attacking stat" do
    visit attacking_stat_url(@attacking_stat)
    click_on "Destroy this attacking stat", match: :first

    assert_text "Attacking stat was successfully destroyed"
  end
end

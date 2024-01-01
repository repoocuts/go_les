require "application_system_test_case"

class GoalsScoredStatsTest < ApplicationSystemTestCase
  setup do
    @goals_scored_stat = goals_scored_stats(:one)
  end

  test "visiting the index" do
    visit goals_scored_stats_url
    assert_selector "h1", text: "Goals scored stats"
  end

  test "should create goals scored stat" do
    visit goals_scored_stats_url
    click_on "New goals scored stat"

    click_on "Create Goals scored stat"

    assert_text "Goals scored stat was successfully created"
    click_on "Back"
  end

  test "should update Goals scored stat" do
    visit goals_scored_stat_url(@goals_scored_stat)
    click_on "Edit this goals scored stat", match: :first

    click_on "Update Goals scored stat"

    assert_text "Goals scored stat was successfully updated"
    click_on "Back"
  end

  test "should destroy Goals scored stat" do
    visit goals_scored_stat_url(@goals_scored_stat)
    click_on "Destroy this goals scored stat", match: :first

    assert_text "Goals scored stat was successfully destroyed"
  end
end

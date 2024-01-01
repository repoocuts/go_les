require "application_system_test_case"

class GoalsConcededStatsTest < ApplicationSystemTestCase
  setup do
    @goals_conceded_stat = goals_conceded_stats(:one)
  end

  test "visiting the index" do
    visit goals_conceded_stats_url
    assert_selector "h1", text: "Goals conceded stats"
  end

  test "should create goals conceded stat" do
    visit goals_conceded_stats_url
    click_on "New goals conceded stat"

    click_on "Create Goals conceded stat"

    assert_text "Goals conceded stat was successfully created"
    click_on "Back"
  end

  test "should update Goals conceded stat" do
    visit goals_conceded_stat_url(@goals_conceded_stat)
    click_on "Edit this goals conceded stat", match: :first

    click_on "Update Goals conceded stat"

    assert_text "Goals conceded stat was successfully updated"
    click_on "Back"
  end

  test "should destroy Goals conceded stat" do
    visit goals_conceded_stat_url(@goals_conceded_stat)
    click_on "Destroy this goals conceded stat", match: :first

    assert_text "Goals conceded stat was successfully destroyed"
  end
end

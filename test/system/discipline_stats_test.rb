require "application_system_test_case"

class DisciplineStatsTest < ApplicationSystemTestCase
  setup do
    @discipline_stat = discipline_stats(:one)
  end

  test "visiting the index" do
    visit discipline_stats_url
    assert_selector "h1", text: "Discipline stats"
  end

  test "should create discipline stat" do
    visit discipline_stats_url
    click_on "New discipline stat"

    click_on "Create Discipline stat"

    assert_text "Discipline stat was successfully created"
    click_on "Back"
  end

  test "should update Discipline stat" do
    visit discipline_stat_url(@discipline_stat)
    click_on "Edit this discipline stat", match: :first

    click_on "Update Discipline stat"

    assert_text "Discipline stat was successfully updated"
    click_on "Back"
  end

  test "should destroy Discipline stat" do
    visit discipline_stat_url(@discipline_stat)
    click_on "Destroy this discipline stat", match: :first

    assert_text "Discipline stat was successfully destroyed"
  end
end

require "application_system_test_case"

class GoalsTest < ApplicationSystemTestCase
  setup do
    @goal = goals(:one)
  end

  test "visiting the index" do
    visit goals_url
    assert_selector "h1", text: "Goals"
  end

  test "should create goal" do
    visit goals_url
    click_on "New goal"

    fill_in "Fixture", with: @goal.fixture_id
    fill_in "Goal type", with: @goal.goal_type
    check "Is home" if @goal.is_home
    fill_in "Minute", with: @goal.minute
    check "Own goal" if @goal.own_goal
    fill_in "Player season", with: @goal.player_season_id
    fill_in "Team season", with: @goal.team_season_id
    click_on "Create Goal"

    assert_text "Goal was successfully created"
    click_on "Back"
  end

  test "should update Goal" do
    visit goal_url(@goal)
    click_on "Edit this goal", match: :first

    fill_in "Fixture", with: @goal.fixture_id
    fill_in "Goal type", with: @goal.goal_type
    check "Is home" if @goal.is_home
    fill_in "Minute", with: @goal.minute
    check "Own goal" if @goal.own_goal
    fill_in "Player season", with: @goal.player_season_id
    fill_in "Team season", with: @goal.team_season_id
    click_on "Update Goal"

    assert_text "Goal was successfully updated"
    click_on "Back"
  end

  test "should destroy Goal" do
    visit goal_url(@goal)
    click_on "Destroy this goal", match: :first

    assert_text "Goal was successfully destroyed"
  end
end

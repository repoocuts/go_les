require "application_system_test_case"

class RefereesTest < ApplicationSystemTestCase
  setup do
    @referee = referees(:one)
  end

  test "visiting the index" do
    visit referees_url
    assert_selector "h1", text: "Referees"
  end

  test "should create referee" do
    visit referees_url
    click_on "New referee"

    fill_in "Name", with: @referee.name
    fill_in "Season", with: @referee.season_id
    click_on "Create Referee"

    assert_text "Referee was successfully created"
    click_on "Back"
  end

  test "should update Referee" do
    visit referee_url(@referee)
    click_on "Edit this referee", match: :first

    fill_in "Name", with: @referee.name
    fill_in "Season", with: @referee.season_id
    click_on "Update Referee"

    assert_text "Referee was successfully updated"
    click_on "Back"
  end

  test "should destroy Referee" do
    visit referee_url(@referee)
    click_on "Destroy this referee", match: :first

    assert_text "Referee was successfully destroyed"
  end
end

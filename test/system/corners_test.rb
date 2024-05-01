require "application_system_test_case"

class CornersTest < ApplicationSystemTestCase
  setup do
    @corner = corners(:one)
  end

  test "visiting the index" do
    visit corners_url
    assert_selector "h1", text: "Corners"
  end

  test "should create corner" do
    visit corners_url
    click_on "New corner"

    click_on "Create Corner"

    assert_text "Corner was successfully created"
    click_on "Back"
  end

  test "should update Corner" do
    visit corner_url(@corner)
    click_on "Edit this corner", match: :first

    click_on "Update Corner"

    assert_text "Corner was successfully updated"
    click_on "Back"
  end

  test "should destroy Corner" do
    visit corner_url(@corner)
    click_on "Destroy this corner", match: :first

    assert_text "Corner was successfully destroyed"
  end
end

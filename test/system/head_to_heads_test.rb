require "application_system_test_case"

class HeadToHeadsTest < ApplicationSystemTestCase
  setup do
    @head_to_head = head_to_heads(:one)
  end

  test "visiting the index" do
    visit head_to_heads_url
    assert_selector "h1", text: "Head to heads"
  end

  test "should create head to head" do
    visit head_to_heads_url
    click_on "New head to head"

    click_on "Create Head to head"

    assert_text "Head to head was successfully created"
    click_on "Back"
  end

  test "should update Head to head" do
    visit head_to_head_url(@head_to_head)
    click_on "Edit this head to head", match: :first

    click_on "Update Head to head"

    assert_text "Head to head was successfully updated"
    click_on "Back"
  end

  test "should destroy Head to head" do
    visit head_to_head_url(@head_to_head)
    click_on "Destroy this head to head", match: :first

    assert_text "Head to head was successfully destroyed"
  end
end

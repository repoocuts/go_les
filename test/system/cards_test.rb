require "application_system_test_case"

class CardsTest < ApplicationSystemTestCase
  setup do
    @card = cards(:one)
  end

  test "visiting the index" do
    visit cards_url
    assert_selector "h1", text: "Cards"
  end

  test "should create card" do
    visit cards_url
    click_on "New card"

    fill_in "Appearance", with: @card.appearance_id
    fill_in "Card type", with: @card.card_type
    fill_in "First card", with: @card.first_card_id
    fill_in "Fixture", with: @card.fixture_id
    check "Is home" if @card.is_home
    fill_in "Minute", with: @card.minute
    fill_in "Player season", with: @card.player_season_id
    fill_in "Team season", with: @card.team_season_id
    click_on "Create Card"

    assert_text "Card was successfully created"
    click_on "Back"
  end

  test "should update Card" do
    visit card_url(@card)
    click_on "Edit this card", match: :first

    fill_in "Appearance", with: @card.appearance_id
    fill_in "Card type", with: @card.card_type
    fill_in "First card", with: @card.first_card_id
    fill_in "Fixture", with: @card.fixture_id
    check "Is home" if @card.is_home
    fill_in "Minute", with: @card.minute
    fill_in "Player season", with: @card.player_season_id
    fill_in "Team season", with: @card.team_season_id
    click_on "Update Card"

    assert_text "Card was successfully updated"
    click_on "Back"
  end

  test "should destroy Card" do
    visit card_url(@card)
    click_on "Destroy this card", match: :first

    assert_text "Card was successfully destroyed"
  end
end

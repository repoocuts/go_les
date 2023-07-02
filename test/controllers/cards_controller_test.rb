require "test_helper"

class CardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @card = cards(:one)
  end

  test "should get index" do
    get cards_url
    assert_response :success
  end

  test "should get new" do
    get new_card_url
    assert_response :success
  end

  test "should create card" do
    assert_difference("Card.count") do
      post cards_url, params: { card: { appearance_id: @card.appearance_id, card_type: @card.card_type, first_card_id: @card.first_card_id, fixture_id: @card.fixture_id, is_home: @card.is_home, minute: @card.minute, player_season_id: @card.player_season_id, team_season_id: @card.team_season_id } }
    end

    assert_redirected_to card_url(Card.last)
  end

  test "should show card" do
    get card_url(@card)
    assert_response :success
  end

  test "should get edit" do
    get edit_card_url(@card)
    assert_response :success
  end

  test "should update card" do
    patch card_url(@card), params: { card: { appearance_id: @card.appearance_id, card_type: @card.card_type, first_card_id: @card.first_card_id, fixture_id: @card.fixture_id, is_home: @card.is_home, minute: @card.minute, player_season_id: @card.player_season_id, team_season_id: @card.team_season_id } }
    assert_redirected_to card_url(@card)
  end

  test "should destroy card" do
    assert_difference("Card.count", -1) do
      delete card_url(@card)
    end

    assert_redirected_to cards_url
  end
end

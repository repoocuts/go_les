require "test_helper"

class RefereeFixturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @referee_fixture = referee_fixtures(:one)
  end

  test "should get index" do
    get referee_fixtures_url
    assert_response :success
  end

  test "should get new" do
    get new_referee_fixture_url
    assert_response :success
  end

  test "should create referee_fixture" do
    assert_difference("RefereeFixture.count") do
      post referee_fixtures_url, params: { referee_fixture: { fixture_id: @referee_fixture.fixture_id, referee_id: @referee_fixture.referee_id, season_id: @referee_fixture.season_id } }
    end

    assert_redirected_to referee_fixture_url(RefereeFixture.last)
  end

  test "should show referee_fixture" do
    get referee_fixture_url(@referee_fixture)
    assert_response :success
  end

  test "should get edit" do
    get edit_referee_fixture_url(@referee_fixture)
    assert_response :success
  end

  test "should update referee_fixture" do
    patch referee_fixture_url(@referee_fixture), params: { referee_fixture: { fixture_id: @referee_fixture.fixture_id, referee_id: @referee_fixture.referee_id, season_id: @referee_fixture.season_id } }
    assert_redirected_to referee_fixture_url(@referee_fixture)
  end

  test "should destroy referee_fixture" do
    assert_difference("RefereeFixture.count", -1) do
      delete referee_fixture_url(@referee_fixture)
    end

    assert_redirected_to referee_fixtures_url
  end
end

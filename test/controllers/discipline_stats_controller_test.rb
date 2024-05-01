require "test_helper"

class DisciplineStatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @discipline_stat = discipline_stats(:one)
  end

  test "should get index" do
    get discipline_stats_url
    assert_response :success
  end

  test "should get new" do
    get new_discipline_stat_url
    assert_response :success
  end

  test "should create discipline_stat" do
    assert_difference("DisciplineStat.count") do
      post discipline_stats_url, params: { discipline_stat: {  } }
    end

    assert_redirected_to discipline_stat_url(DisciplineStat.last)
  end

  test "should show discipline_stat" do
    get discipline_stat_url(@discipline_stat)
    assert_response :success
  end

  test "should get edit" do
    get edit_discipline_stat_url(@discipline_stat)
    assert_response :success
  end

  test "should update discipline_stat" do
    patch discipline_stat_url(@discipline_stat), params: { discipline_stat: {  } }
    assert_redirected_to discipline_stat_url(@discipline_stat)
  end

  test "should destroy discipline_stat" do
    assert_difference("DisciplineStat.count", -1) do
      delete discipline_stat_url(@discipline_stat)
    end

    assert_redirected_to discipline_stats_url
  end
end

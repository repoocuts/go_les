class Creators::SeasonCreator < ApiFootball

  def create_season(league)
    start_date = DateTime.new(2022, 8, 1)
    end_date = DateTime.new(2023, 5, 31)
    Season.create(start_date: start_date, end_date: end_date, league_id: league.id, current_season: true, current_game_week: 1)
  end

  private

  def interpolate_endpoint
    base_uri + ENDPOINT
  end
end
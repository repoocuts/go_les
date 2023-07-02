class Creators::FixtureCreator < ApiFootball

  ENDPOINT = 'fixtures'

  def create_fixture(league_api_football_id, season_start_date_year)
    fixtures = call['response']
    fixtures.map { |elem| create_from_response(elem) }
  end

  private

  attr_reader :league_api_football_id

  def interpolate_endpoint
    base_uri + ENDPOINT
  end

  def create_from_response(response_element)
    league = League.first
    season = league.seasons.where(current_season: true).first
    Fixture.create(
      api_football_id: response_element['fixture']['id'],
      away_team_season_id: get_away_team_season_id(response_element['teams']['away']),
      home_team_season_id: get_home_team_season_id(response_element['teams']['home']),
      kick_off: response_element['fixture']['date'],
      league_id: league.id,
      season_id: season.id,
    )
  end

  def get_home_team_season_id(response_home_team_element)
    team = Team.find_by(api_football_id: response_home_team_element['id'])
    team.team_seasons.where(current_season: true).first.id
  end

  def get_away_team_season_id(response_away_team_element)
    team = Team.find_by(api_football_id: response_away_team_element['id'])
    team.team_seasons.where(current_season: true).first.id
  end
end